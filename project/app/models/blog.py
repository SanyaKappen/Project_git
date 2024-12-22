from sqlalchemy import Boolean,Column,Integer,String
from app.config.database import Base

class SignUpUser(Base):
    __tablename__ = "usersignup"
    id=Column(Integer,primary_key=True,index=True)
    name =Column(String(50),index=True)
    phone_no=Column(String(13),index=True)

class DetailsSender(Base):
    __tablename__ = "senderdetails"
    id=Column(Integer,primary_key=True,index=True)
    pickup_location = Column(String,index=True)
    parcel_size = Column(String,index=True)
    parcel_type = Column(String,index=True)
    pincode = Column(Integer,index=True)
    mode = Column(String,index=True)
    ecomode = Column(Boolean,default=False)

class DetailsRecevier(Base):
    __tablename__= "recevierdetails"
    id=Column(Integer,primary_key=True,index=True)
    receiver_name= Column(String,index=True)
    address=  Column(String,index=True)
    pincode= Column(Integer,index=True)
    phone_no= Column(String(13),index=True)


class Order(Base):
       __tablename__ = "order"
       id=Column(Integer,primary_key=True,index=True)
       pickup_location = Column(Integer,index=True)
       parcel_size= Column(Integer,index=True)
       parcel_type= Column(Integer,index=True)
       pincode= Column(Integer,index=True)
       mode = Column(Integer,index=True)
       ecomode = Column(Boolean,default=False)
       receiver_name = Column(Integer,index=True)
       address= Column(Integer,index=True)
       pincode= Column(Integer,index=True)
       phone_no= Column(String(13),index=True)

class TrackingOrder(Base):
    __tablename__ = "tracking"
    id=Column(Integer,primary_key=True,index=True)
    status= Column(String,index=True)
    current_location= Column(String,index=True)

class ReviewDetails(Base):
    __tablename__ =  "review"
    id=Column(Integer,primary_key=True,index=True)
    reviews = Column(String,index=True)

class SignupAdmin(Base):
    __tablename__ = "adminsignup"
    id=Column(Integer,primary_key=True,index=True)
    name = Column(String,index=True)
    phone_no = Column(String(13),index=True)

class SignupDeliveryPerson(Base):
     __tablename__ = "deliverypersonsignup"
     id=Column(Integer,primary_key=True,index=True)
     name = Column(String,index=True)
     phone_no = Column(String(13),index=True)
     adhaar_no = Column(Integer,index=True)
     vehicle_no = Column(String,index=True)
     license_no = Column(String,index=True)
    
class OTPMessage(Base):
    __tablename__ = "otpmessage"   
    id=Column(Integer,primary_key=True,index=True)
    phone_no = Column(String(13),index=True)
    otp = Column(String,index=True)