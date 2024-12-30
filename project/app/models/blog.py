from datetime import datetime,timezone
from sqlalchemy import Boolean,Column, Float, ForeignKey,Integer,String,DateTime
from sqlalchemy.orm import relationship
from app.config.database import Base

class User(Base):
    __tablename__ = "users"

    user_id = Column(Integer, primary_key=True, index=True)
    phone_no = Column(String(13), unique=True, index=True)
    created_at = Column(DateTime, default=lambda: datetime.now(timezone.utc))


class TrackingOrder(Base):
    __tablename__ = "tracking"
    tracking_id=Column(Integer,primary_key=True,index=True)
    order_id = Column(Integer, ForeignKey("order.order_id"), index=True)
    status= Column(Boolean,default=False)
    current_location= Column(String,index=True)
    order = relationship("Order", back_populates="tracking")

class ReviewDetails(Base):
    __tablename__ =  "review"
    review_id=Column(Integer,primary_key=True,index=True)
    reviews = Column(String,index=True)

class SignupAdmin(Base):
    __tablename__ = "adminsignup"
    admin_id=Column(Integer,primary_key=True,index=True)
    name = Column(String,index=True)
    phone_no = Column(String(13),index=True)

class SignupDeliveryPerson(Base):
     __tablename__ = "deliverypersonsignup"
     deliveryperson_id=Column(Integer,primary_key=True,index=True)
     name = Column(String,index=True)
     phone_no = Column(String(13),index=True)
     adhaar_no = Column(Integer,index=True)
     vehicle_no = Column(String,index=True)
     license_no = Column(String,index=True)
    
class OTPMessage(Base):
    __tablename__ = "otpmessage"   
    otp_id=Column(Integer,primary_key=True,index=True)
    phone_no = Column(String(13),index=True)
    otp = Column(String,index=True)

class CalculateOrder(Base):
    __tablename__ = "calculate"
    calculate_id = Column(Integer,primary_key=True)
    order_id = Column(Integer, ForeignKey("order.order_id"), index=True)
    pickup_date = Column(String, index=True)
    delivery_date = Column(String, index=True)
    price = Column(Float,nullable=False)


class Order(Base):
       __tablename__ = "order"
       order_id=Column(Integer,primary_key=True,index=True) 
       user_id = Column(Integer, ForeignKey("User.user_id"), index=True)
       sender_name = Column(String,index=True)
       sender_phoneno= Column(String(13),index=True)
       pickup_location = Column(String,index=True)
       package_size= Column(String,index=True)
       package_type= Column(String,index=True)
       sender_pincode= Column(Integer,index=True)
       mode = Column(String,index=True)
       receiver_name = Column(String,index=True)
       receiver_address= Column(String,index=True)
       receiver_pincode= Column(Integer,index=True)
       receiver_phoneno= Column(String(13),index=True)
       pickup_date = Column(String, index=True)
       delivery_date = Column(String, index=True)
       price = Column(Float,nullable=False)
       user = relationship("User", backref="orders")
       tracking = relationship("Tracking", back_populates="order")
      
     