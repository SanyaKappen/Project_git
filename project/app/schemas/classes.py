from datetime import datetime
from typing import Optional
from pydantic import BaseModel

class UserDetail(BaseModel):
    id: int
    phone_no: str

class Tracking(BaseModel):
    status: bool
    current_location: str

class Reviews(BaseModel):
    reviews: str

class AdminLogin(BaseModel):
    phone_no: int


class AdminSignup(BaseModel):
    name: str
    phone_no: int
  

class DeliveryPersonLogin(BaseModel):
    phone_no: int
  

class DeliveryPersonSignup(BaseModel):
    name: str
    phone_no: int
    adhaar_no: int
    vehicle_no: str
    license_no: str
    
class PhoneOTP(BaseModel):
    phone_no: str
    
class VerifyOTP(BaseModel):
    phone_no: str
    otp:str

class CalculateDetails(BaseModel):
    package_size: str
    package_type: str 
    mode:  str



class Calculate(BaseModel):
    pickup_date: str
    delivery_date : str
    price: float

class OrderBase(CalculateDetails,Calculate):
    order_id: int
    sender_name: str
    sender_phoneno: str
    pickup_location: str
    sender_pincode: int
    package_type: str
    package_size: str 
    receiver_name: str
    receiver_address: str
    receiver_pincode: int
    receiver_phoneno: str
    mode: str
    price: int
    status: Optional[str] = "pending"

class OrderCreate(OrderBase):
    user_id: int

class OrderResponse(OrderBase):
    id: int
    user_id: int

    class Config:
        from_attributes = True