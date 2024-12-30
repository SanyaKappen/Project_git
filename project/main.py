from fastapi import FastAPI

from app.config import database


from app.routes.user import user
from app.models.blog import Order,TrackingOrder,ReviewDetails,SignupAdmin,SignupDeliveryPerson,OTPMessage,CalculateOrder
from app.schemas.classes import UserDetail,Tracking,Reviews,DeliveryPersonSignup,PhoneOTP,VerifyOTP,CalculateDetails,Calculate,OrderBase,OrderCreate,OrderResponse
from app.config import database

from fastapi.middleware.cors import CORSMiddleware

from app.config.database import engine

app = FastAPI()


app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(user)
database.Base.metadata.create_all(bind=engine)

