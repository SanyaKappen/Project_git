from typing import List
from fastapi import APIRouter,Depends
from fastapi import HTTPException
from app.schemas.classes import Tracking,Reviews,DeliveryPersonSignup,OrderResponse,OrderBase,OrderCreate,OrderResponse,PhoneOTP,VerifyOTP,CalculateDetails,Calculate,UserDetail
from app.models.blog import Order,TrackingOrder,ReviewDetails,SignupDeliveryPerson,OTPMessage,CalculateOrder,User
from app.config import database
from app.config.otp import client,TWILIO_PHONE_NUMBER
from sqlalchemy.orm import Session
import app.models
import random
from datetime import datetime,timedelta

user = APIRouter()
get_db= database.get_db      
    


@user.post('order_details',response_model= OrderBase)   
def post_orders(request: OrderBase,db: Session = Depends(get_db)):
      order = Order(
            sender_name = request.sender_name,
            sender_phoneno = request.sender_phoneno,
            pickup_location = request.pickup_location,
            package_type = request.package_type,
            package_size = request. package_size,
            sender_pincode= request.sender_pincode,
            mode =request.mode,
            receiver_name= request.receiver_name,
            receiver_address=request.receiver_address,
            price= request. price,
            receiver_pincode =request.receiver_pincode,
            receiver_phoneno = request.receiver_phoneno,
            pickup_date=request.pickup_date,
            delivery_date=request.delivery_date,

      )
      db.add(order)
      db.commit()
      db.refresh(order)
      return order

        

@user.post('/reviews',response_model = Reviews)
def post_reviews(request: Reviews,db: Session = Depends(get_db)):
     
       review = ReviewDetails(
              reviews = request.review
       )
       db.add(review)
       db.commit()
       db.refresh(review)
       return review



@user.get("/user/orders", response_model=List[OrderResponse])
def get_user_orders(user_id: str, db: Session = Depends(get_db)):
    orders = db.query(Order).filter(Order.user_id == user_id).all()

    if not orders:
        raise HTTPException(status_code=404, detail="No orders found for the user")

    return orders     

@user.get("/delivery/orders", response_model=List[OrderResponse])
def get_delivery_orders(vehicle_type: str, db: Session = Depends(get_db)):
    if vehicle_type.lower() == "electric":
        orders = db.query(Order).filter(Order.mode == "eco_mode", Order.status == "pending").all()
    else:
        orders = db.query(Order).filter(Order.mode.in_(["express", "standard"]), Order.status == "pending").all()

    if not orders:
        raise HTTPException(status_code=404, detail="No orders available for delivery")

    return orders
@user.post("/delivery/order/action")
def handle_order_action(order_id: int, action: str, db: Session = Depends(get_db)):
    order = db.query(Order).filter(Order.id == order_id).first()

    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    if action.lower() not in ["accept", "decline"]:
        raise HTTPException(status_code=400, detail="Invalid action")

    if action.lower() == "accept":
        order.status = "accepted"
    elif action.lower() == "decline":
        order.status = "declined"

    db.commit()
    db.refresh(order)
    return {"message": f"Order {action}ed successfully"}

@user.get("/user/orders/track/{order_id}", response_model=Tracking)
def track_order(order_id: int, db: Session = Depends(get_db)):
    tracking = db.query(TrackingOrder).filter(TrackingOrder.id == order_id).first()

    if not tracking:
        raise HTTPException(status_code=404, detail="Tracking information not found")

    return tracking




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
        message=f"Your OTP is:{otp}"
        client.messages.create(to=phone_no, from_= TWILIO_PHONE_NUMBER,body=message)

@user.post('/send_otp')
async def send_otp_route(phoneotp: PhoneOTP, db: Session = Depends(get_db)):
    try:
        otp = generate_otp()

        existing_otp = db.query(OTPMessage).filter(OTPMessage.phone_no == phoneotp.phone_no).first()
        if existing_otp:    
            existing_otp.otp = otp
        else:
            new_otp = OTPMessage(phone_no=phoneotp.phone_no, otp=otp)
            db.add(new_otp)   
        db.commit()      
        send_otp(phoneotp.phone_no, otp)

        return {"detail": "OTP sent successfully"}

    except Exception as e:
        print(f"Error sending OTP: {e}")
        raise HTTPException(status_code=500, detail="Failed to send OTP")
    
@user.post('/verify_otp')
async def verify_otp_route(otp_data: VerifyOTP, db: Session = Depends(get_db)):
    try:
        print(f"Verifying OTP for phone_no: {otp_data.phone_no}")

        # Retrieve OTP record for the given phone number
        otp_message = db.query(OTPMessage).filter(OTPMessage.phone_no == otp_data.phone_no).first()
        print(f"OTP message found: {otp_message}")

        if not otp_message:
            raise HTTPException(status_code=400, detail="OTP not found")

        # Validate the OTP
        if otp_message.otp != otp_data.otp:
            print(f"Invalid OTP. Expected: {otp_message.otp}, Received: {otp_data.otp}")
            raise HTTPException(status_code=400, detail="Invalid OTP")

        # Delete OTP record after successful verification
        db.delete(otp_message)
        db.commit()
        print(f"Deleted OTP record for phone_no: {otp_data.phone_no}")

        # Check if the phone number exists in the users table
        existing_user = db.query(User).filter(User.phone_no == otp_data.phone_no).first()
        print(f"Existing user found: {existing_user}")

        if existing_user:
            print(f"Returning details for existing user: {existing_user.phone_no}")
            return UserDetail(id=existing_user.id, phone_no=existing_user.phone_no)
        else:
            # Signup process for a new user
            print(f"Creating new user for phone_no: {otp_data.phone_no}")
            new_user = User(phone_no=otp_data.phone_no)
            db.add(new_user)
            db.commit()
            db.refresh(new_user)
            print(f"New user created with ID: {new_user.id}")

            return UserDetail(id=new_user.id, phone_no=new_user.phone_no)

    except HTTPException as e:
        print(f"HTTPException during OTP verification: {e.detail}")
        raise e
    except Exception as e:
        print(f"Unexpected error during OTP verification: {e}")
        raise HTTPException(status_code=500, detail="Server error during OTP verification")


def round_time(dt: datetime) -> datetime:
    # Round to the nearest 30 minutes
    minute = dt.minute
    if minute < 15:  # If less than 15 minutes, round down to 00
        rounded_minute = 0
    elif minute < 45:  # If between 15 and 45, round to 30
        rounded_minute = 30
    else:  # If 45 or above, round up to the next hour
        rounded_minute = 0
        dt += timedelta(hours=1)  # Increment the hour
    return dt.replace(minute=rounded_minute, second=0, microsecond=0)   
     
def calculate_price(package_size: str, package_type: str, mode: str) -> dict:
    print(f"Selected mode: {mode}") 
    base_price_per_kg = 50
    package_type_modifiers = {
        'Automobiles': 1.5,
        'Packaged Food': 1.2,
        'Health & Wellness': 1.1,
        'Electronics': 1.3,
        'Books & Stationery': 1.0,
        'Documents': 0.8,
    }
    
    delivery_mode_modifier = 1.0
    if mode == 'express_mode':
        delivery_mode_modifier = 1.5
    elif mode == 'eco_mode':
        delivery_mode_modifier = 0.9

    weight = 0.0
    if package_size == 'Extra small Package (Max. 500 gm)':
        weight = 0.5
    elif package_size == 'Small Package (500 gm - 2 kg)':
        weight = 1.0
    elif package_size == 'Medium Package (2 kg - 5 kg)':
        weight = 3.5
    elif package_size == 'Large Package (5 kg - 10 kg)':
        weight = 7.5

    base_price = base_price_per_kg * weight
    price_with_type = base_price * package_type_modifiers.get(package_type, 1.0)
    total_price = price_with_type * delivery_mode_modifier
    return round(total_price)

# Combined function to calculate dates and price
@user.post('/calculate', response_model=Calculate)
async def calculate(details: CalculateDetails, db: Session = Depends(get_db)):
    try:
        # Calculate price
        total_price = calculate_price(details.package_size, details.package_type, details.mode)

        # Current date and time
        current_date = datetime.now()

        # Define logic for delivery modes
        if details.mode == "express_mode":
            pickup_date = current_date + timedelta(hours=6)  # Pickup within 6 hours
            delivery_date = current_date + timedelta(days=1)  # Deliver in 1 day
        elif details.mode == "eco_mode":
            pickup_date = current_date + timedelta(days=1)  # Pickup next day
            delivery_date = current_date + timedelta(days=5)  # Deliver in 5 days
        else:  # "standard"
            pickup_date = current_date + timedelta(days=1)  # Pickup next day
            delivery_date = current_date + timedelta(days=3)  # Deliver in 3 days

        # Round pickup and delivery times
        pickup_date_rounded = round_time(pickup_date)
        delivery_date_rounded = round_time(delivery_date)

        # Save to database
        calculate = CalculateOrder(
            pickup_date=pickup_date_rounded.strftime('%Y-%m-%d %I:%M %p'),
            delivery_date=delivery_date_rounded.strftime('%Y-%m-%d %I:%M %p'),
            price=total_price 
        )
        db.add(calculate)
        db.commit()
        db.refresh(calculate)

        # Return response
        return {
            "price": total_price,
            "pickup_date": f"Date - {pickup_date_rounded.strftime('%d/%m/%Y')}, /n Time - {pickup_date_rounded.strftime('%I:%M %p')}",
            "delivery_date": f"Date - {delivery_date_rounded.strftime('%d/%m/%Y')},/n Time - {delivery_date_rounded.strftime('%I:%M %p')}",
            "message": "Dates and price calculated successfully",
        }
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

  
        


          