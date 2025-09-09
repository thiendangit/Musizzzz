from fastapi import UploadFile, Form
from pydantic import BaseModel
from typing import Optional


class SongUploadRequest(BaseModel):
    name: str
    artist: str
    hex_code: str
    thumbnail: UploadFile
    song_file: UploadFile

class SongBase(BaseModel):
    name: str
    artist: str
    hex_code: str
    thumbnail: str

class SongCreate(SongBase):
    user_id: str
    song_file: str

class Song(SongBase):
    id: str
    user_id: str
    song_file: str
    
    class Config:
        from_attributes = True

class SongResponse(BaseModel):
    id: str
    name: str
    artist: str
    hex_code: str
    song_file: str
    thumbnail: str
    user_id: str
    
    class Config:
        from_attributes = True
