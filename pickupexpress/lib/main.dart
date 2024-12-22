import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/category_screen.dart';
import 'package:pickupexpress/screens/confirmation_screen.dart';
import 'package:pickupexpress/screens/deliverypersonsignup_screen.dart';

import 'package:pickupexpress/screens/get_otp.dart';
import 'package:pickupexpress/screens/home_screen.dart';
import 'package:pickupexpress/screens/login_screen.dart';
import 'package:pickupexpress/screens/receiver_details.dart';
import 'package:pickupexpress/screens/selectmode_screen.dart';
import 'package:pickupexpress/screens/sender_details.dart';
import 'package:pickupexpress/screens/update_screen.dart';

import 'package:pickupexpress/screens/usersignup_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: HomeScreen()
    
    );
  }
}
