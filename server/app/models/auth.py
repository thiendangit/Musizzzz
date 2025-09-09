from sqlalchemy import Column, String
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from app.db.database import Base
import uuid

class User(Base):
    __tablename__ = "users"

    id = Column(String, primary_key=True, default=uuid.uuid4)
    username = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    password = Column(String, nullable=False)
    
    # Relationship to songs
    songs = relationship("Song", back_populates="user")