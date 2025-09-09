import uuid
from sqlalchemy import Column, ForeignKey
from sqlalchemy.types import Integer, String
from sqlalchemy.orm import relationship

from app.db.database import Base


class Song(Base):
    __tablename__ = "songs"

    id = Column(String, primary_key=True, default=uuid.uuid4)
    name = Column(String, nullable=False)
    artist = Column(String, nullable=False)
    thumbnail = Column(String, nullable=False)
    song_file = Column(String, nullable=False)
    hex_code = Column(String, nullable=False)
    user_id = Column(String, ForeignKey("users.id"), nullable=False)
    
    # Relationship to User
    user = relationship("User", back_populates="songs")