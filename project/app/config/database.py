from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from typing import Annotated
from sqlalchemy.orm import Session
from fastapi import Depends
# from models.blog import SignUpUser,DetailsSender,DetailsRecevier,Order,TrackingOrder,ReviewDetails,SignupAdmin,SignupDeliveryPerson,OTPMessage
SQLALCHEMY_DATABASE_URL = 'postgresql://postgres:user123@localhost:5432/Project'

engine = create_engine(SQLALCHEMY_DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()
# def init_db():
#     """Initialize the database and create tables if they don't exist."""
#     # from models.blog import SignUpUser,DetailsSender,DetailsRecevier,Order,TrackingOrder,ReviewDetails,SignupAdmin,SignupDeliveryPerson,OTPMessage
#     from models import Base
#     Base.metadata.create_all(bind=engine)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
db_dependency=Annotated[Session,Depends(get_db)]
