from pydantic import BaseModel

class FavoriteBase(BaseModel):
  userId: str;
  songId: str;

class Favorite(FavoriteBase):
  id: str;

class FavoriteCreate(FavoriteBase):
  userId: str;
  songId: str;