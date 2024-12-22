from fastapi import APIRouter,Depends
from fastapi import HTTPException
from app.schemas.classes import UserLogin,UserSignup,SenderDetails,ReceiverDetails,Tracking,Reviews,AdminLogin,AdminSignup,DeliveryPersonLogin,DeliveryPersonSignup,Details,PhoneOTP,VerifyOTP,ShippingDetails
from app.models.blog import SignUpUser,DetailsSender,DetailsRecevier,Order,TrackingOrder,ReviewDetails,SignupAdmin,SignupDeliveryPerson,OTPMessage
from app.config import database
from app.config.otp import client,TWILIO_PHONE_NUMBER
from sqlalchemy.orm import Session
import app.models
import random
from datetime import datetime,timedelta

user = APIRouter()
get_db= database.get_db

# @user.post('/user_login',response_model=schemas.UserLogin)
# def post_userlogin(uselogin: UserLogin,db: Session = Depends(get_db)):
#          usersignup = schemas.UserSignup(phone_no=usersignup.phone_no)
#          db.add(usersignup)
#          db.commit()
#          db.refresh(usersignup)
#          return usersign
       
         

@user.post('/user_signup',response_model = UserSignup)
def post_usersignup(request: UserSignup,db: Session = Depends(get_db)):
         user_signup = SignUpUser(name = request.name,phone_no=request.phone_no)
         db.add(user_signup)
         db.commit()
         db.refresh(user_signup)
         return user_signup
         
     
@user.post('/sender_details',response_model = SenderDetails)
def post_senderdetails(request: SenderDetails,db: Session = Depends(get_db)):
      sender_details = DetailsSender( 
                   
             pickup_location=request.pickup_location,
             parcel_size=request.parcel_size,
             parcel_type=request.parcel_type,
             pincode=request.pincode,
             mode=request.mode,
             eco_mode=request.ecomode)
      db.add(sender_details)
      db.commit()
      db.refresh(sender_details)
      return sender_details
      
           
      
@user.post('/receiver_details',response_model = ReceiverDetails)
def post_receiverdetails(request: ReceiverDetails,db: Session = Depends(get_db)):
    
     receiver_details = DetailsRecevier(               
            receiver_name = request.receiver_name,
            address = request.address,
            pincode =request.pincode,
            phone_no = request.phone_no)
     db.add(receiver_details)
     db.commit()
     db.refresh(receiver_details)
     return receiver_details
     
           
@user.post('track',response_model = Tracking)
def post_tracking(request: Tracking,db: Session = Depends(get_db)):
     
          tracking = TrackingOrder(
                 status=request.status,
                 current_location=request.current_location
          )
          db.add(tracking)
          db.commit()
          db.refresh(tracking)
          return tracking

@user.post('/reviews',response_model = Reviews)
def post_reviews(request: Reviews,db: Session = Depends(get_db)):
     
       review = ReviewDetails(
              reviews = request.review
       )
       db.add(review)
       db.commit()
       db.refresh(review)
       return review

          
# @user.post('/admin_login')
# def post_adminlogin(admin_login:AdminLogin):
     
#          return{ "phone_no":admin_login.phone_no,
#           }
     
@user.post('/admin_signup',response_model = UserSignup)
def post_adminsignup(request: AdminSignup,db: Session = Depends(get_db)):
         admin_signup = SignupAdmin(phone_no=request.phone_no)
         db.add(admin_signup)
         db.commit()
         db.refresh(admin_signup)
         return admin_signup

@user.get('/track/{track_id}',response_model=Tracking)
def tracking_details(track_id: int,db: Session = Depends(get_db)):
       track = db.query(TrackingOrder).filter(TrackingOrder.id == track_id).first()
       if not track:
              raise HTTPException(status_code=404,detail="Tracking not found")
       return track
         
@user.get('/order/{order_id}',response_model= Details)
def order_details(order_id: int,db: Session = Depends(get_db)):
       order = db.query(Order).filter(Order.id == order_id).first()
       if not order:
              raise HTTPException(status_code=404,detail="Order not found")
       return order
     
@user.get('/userdetails/{user_id}',response_model= UserSignup) 
def user_details(user_id: int,db: Session = Depends(get_db)):
       user = db.query(SignUpUser).filter(SignUpUser.id == user_id).first()
       if not user:
              raise HTTPException(status_code=404,detail="Users not found")
       return user
    

@user.get('/deliverypersonsdetails/{deliveryperson_id}',response_model=DeliveryPersonSignup)
def deliveryperson_details( deliveryperson_id: int,db: Session = Depends(get_db)):

       deliveryperson = db.query(SignupDeliveryPerson).filter(SignupDeliveryPerson.id == deliveryperson_id).first()
       if not deliveryperson:
              raise HTTPException(status_code=404,detail="DeliveryPersons not found")
       return deliveryperson

@user.get('/reviewdetails/{review_id}',response_model= Reviews)
def reviewdetails(review_id: int,db: Session = Depends(get_db)):
      
       review = db.query(ReviewDetails).filter(ReviewDetails.id == review_id).first()
       if not review:
              raise HTTPException(status_code=404,detail="DeliveryPersons not found")
       return review
     
# @user.post('/deliveryperson_login')
# def post_deliver_person(deliveryperson_login:DeliveryPersonLogin):
     
#           return{     
#           "phone_no":deliveryperson_login.phone_no,
#            }
      
@user.post('/deliveryperson_signup',response_model = DeliveryPersonSignup)
def post_delivery_person(request: DeliveryPersonSignup,db: Session = Depends(get_db)):
     deliverypersonSignup = SignupDeliveryPerson(          
           name= request.name,
           phone_no= request.phone_no,
           vehicle_no= request.vehicle_no,
           license_no = request.license_no,
           adhaar_no= request.adhaar_no
     )
     db.add(deliverypersonSignup)
     db.commit()
     db.refresh(deliverypersonSignup)
     return deliverypersonSignup


def generate_otp():
        return str (random.randint(1000,9999))
def send_otp(phone_no,otp):
        phone_no =phone_no.__str__()
       #  print(type(phone_no))
        message=f"Your OTP is:{otp}"
        client.messages.create(to=phone_no, from_= TWILIO_PHONE_NUMBER,body=message)

@user.post('/send_otp')
async def send_otp_route(phoneotp:PhoneOTP):
        otp=generate_otp()
        OTPMessage.phone_no = phoneotp.phone_no       
        OTPMessage.otp = otp
        
        send_otp(phoneotp.phone_no,otp)
        return{"detail" :"OTP send successfully"}

@user.post('/verify_otp')
async def verify_otp_route(otp_data:VerifyOTP):
     OTPMessage = OTPMessage.get(otp_data.phone_no)
     if not OTPMessage:
        raise HTTPException(status_code=400,detail='OTP not found')
     if OTPMessage!= otp_data.otp:
        raise  HTTPException(status_code=400,detail="invalid OTP")
     OTPMessage.delete(otp_data.phone_no)
     return {"detail":"OTP verified successfully"}  


def round_time(dt: datetime) -> datetime:
    # Round the minutes to nearest 30-minute mark
    new_minute = 30 * (dt.minute // 30)
    return dt.replace(minute=new_minute, second=0, microsecond=0)   

@user.post("/calculate-dates/")
def calculate_dates(details: ShippingDetails):
    # Current date and time
    current_date = datetime.now()
    # Define logic for delivery modes
    if details.delivery_mode == "express":
        pickup_date = current_date + timedelta(hours=6)  # Pickup within 6 hours
        delivery_date = current_date + timedelta(days=1)  # Deliver in 1 day
    elif details.delivery_mode == "eco":
        pickup_date = current_date + timedelta(days=1)  # Pickup next day
        delivery_date = current_date + timedelta(days=5)  # Deliver in 5 days
    else:  # "standard"
        pickup_date = current_date + timedelta(days=1)  # Pickup next day
        delivery_date = current_date + timedelta(days=3)  # Deliver in 3 days
    pickup_date_rounded = round_time(pickup_date)
    delivery_date_rounded = round_time(delivery_date)

    return {
        "pickup_date": f"Date - {pickup_date_rounded.strftime('%d/%m/%Y')}, Time - {pickup_date_rounded.strftime('%I:%M %p')}",
        "delivery_date": f"Date - {delivery_date_rounded.strftime('%d/%m/%Y')}, Time - {delivery_date_rounded.strftime('%I:%M %p')}",
        "message": "Dates calculated successfully",
    }      
     

          
        


          