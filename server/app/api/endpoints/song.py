import os
import uuid
from fastapi import APIRouter, Depends, UploadFile, File, Form, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db 
from app.schemas.song import SongCreate, SongUploadRequest, SongResponse
from app.models.song import Song
from app.utils.auth import get_current_user
from app.models.auth import User
import cloudinary
import cloudinary.uploader


router = APIRouter()

cloudinary.config(
    cloud_name=os.getenv("CLOUDINARY_CLOUD_NAME"),
    api_key=os.getenv("CLOUDINARY_API_KEY"),
    api_secret=os.getenv("CLOUDINARY_API_SECRET"),
    secure=True,
)

@router.post("/upload-song")
def upload_song(
    title: str = Form(...),
    artist: str = Form(...),
    color: str = Form(...),
    thumbnail: UploadFile = File(...),
    song: UploadFile = File(...),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Upload thumbnail to Cloudinary
    thumbnail_result = cloudinary.uploader.upload(
        thumbnail.file,
        resource_type="image",
        use_filename=True,
        unique_filename=True,
        folder="thumbnails"
    )
    
    # Upload song file to Cloudinary
    song_result = cloudinary.uploader.upload(
        song.file,
        resource_type="video",  # Cloudinary uses 'video' for audio files
        use_filename=True,
        unique_filename=True,
        folder="songs"
    )

    create_song = Song(
        id=str(uuid.uuid4()),
        name=title,
        artist=artist,
        hex_code=color,
        thumbnail=thumbnail_result.get("secure_url"),
        song_file=song_result.get("secure_url"),
        user_id=current_user.id
    )

    db.add(create_song)
    db.commit()
    db.refresh(create_song)
    
    return create_song


@router.get("/get-songs")
def get_songs(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    songs = db.query(Song).all()
    return songs