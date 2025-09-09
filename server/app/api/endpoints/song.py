import os
from fastapi import APIRouter, Depends, UploadFile, File, Form, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db 
from app.schemas.song import SongCreate, SongUploadRequest, SongResponse
from app.models.song import Song
from app.utils.auth import get_current_user
import cloudinary
import cloudinary.uploader
import cloudinary.api


router = APIRouter()

cloudinary.config(
    cloud_name=os.getenv("CLOUDINARY_CLOUD_NAME"),
    api_key=os.getenv("CLOUDINARY_API_KEY"),
    api_secret=os.getenv("CLOUDINARY_API_SECRET"),
    secure=True,
)

@router.post("/upload-song")
def upload_song(
    name: str = Form(...),
    artist: str = Form(...),
    hex_code: str = Form(...),
    thumbnail: UploadFile = File(...),
    song_file: UploadFile = File(...),
    db: Session = Depends(get_db),
    auth_dict: dict = Depends(get_current_user)
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
        song_file.file,
        resource_type="video",  # Cloudinary uses 'video' for audio files
        use_filename=True,
        unique_filename=True,
        folder="songs"
    )
    
    return {
        "message": "Files uploaded successfully",
        "thumbnail_url": thumbnail_result.get("secure_url"),
        "song_url": song_result.get("secure_url")
    }