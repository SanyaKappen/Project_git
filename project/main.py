from fastapi import FastAPI

from app.config import database


from app.routes.user import user
from app.models.blog import SignUpUser,DetailsSender,DetailsRecevier,Order,TrackingOrder,ReviewDetails,SignupAdmin,SignupDeliveryPerson,OTPMessage
from app.routes.user import UserLogin,UserSignup,SenderDetails,ReceiverDetails,Tracking,Reviews,AdminLogin,AdminSignup,DeliveryPersonLogin,DeliveryPersonSignup,Details,PhoneOTP,VerifyOTP,ShippingDetails
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

