from pydantic import BaseModel


class FavoriteCreate(BaseModel):
  songId: str


class Favorite(BaseModel):
  id: str
  userId: str
  songId: str