from fastapi import APIRouter

from app.api.endpoints import auth, song

api_router = APIRouter()

# User routes
api_router.include_router(
    auth.router,
    prefix="/auth",
    tags=["auth"]
)

# Songs routes
api_router.include_router(
    song.router,
    prefix="/song", 
    tags=["song"]
)

# Auth routes
# api_router.include_router(
#     auth.router,
#     prefix="/auth", 
#     tags=["auth"]
# )

# Music routes
# api_router.include_router(
#     music.router,
#     prefix="/music",
#     tags=["music"]
# )

# Playlist routes 
# api_router.include_router(
#     playlist.router,
#     prefix="/playlist",
#     tags=["playlist"]
# )