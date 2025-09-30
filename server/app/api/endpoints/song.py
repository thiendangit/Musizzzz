import os
import uuid
from fastapi import APIRouter, Depends, UploadFile, File, Form, HTTPException
from sqlalchemy.orm import Session, joinedload
from app.db.database import get_db 
from app.models.favorite import Favorite
from app.schemas.song import SongCreate, SongUploadRequest, SongResponse
from app.schemas.favorite import FavoriteCreate
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

@router.post("/favorite-song")
def favorite_song(
    favorite_data: FavoriteCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    print(favorite_data)
    # Use the songId from the request body
    effective_song_id = favorite_data.songId

    print(effective_song_id)

    if not effective_song_id:
        raise HTTPException(status_code=400, detail="songId is required")

    # Ensure the song exists to avoid FK violations
    song = db.query(Song).filter(Song.id == effective_song_id).first()
    if not song:
        raise HTTPException(status_code=404, detail="Song not found")

    userId = current_user.id
    existFavorite = db.query(Favorite).filter(Favorite.song_id == effective_song_id, Favorite.user_id == userId).first()

    if not existFavorite:
        createFavorite = Favorite(
            id=str(uuid.uuid4()),
            song_id=effective_song_id,
            user_id=userId
        )
        db.add(createFavorite)
        db.commit()
        db.refresh(createFavorite)
        return {
            "status": "success",
            "message": "Song favorited successfully"
        }
    else:
        db.delete(existFavorite)
        db.commit()
        return {
            "status": 'success',
            "message": 'Song unfavorited successfully'
        }

@router.get("/get-favorite-songs")
def get_favorite_songs(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    songs = db.query(Favorite).filter(Favorite.user_id == current_user.id).options(joinedload(Favorite.song)).all()
    return songs