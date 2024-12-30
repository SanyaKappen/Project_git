import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickupexpress/screens/adminsignup_screen.dart';
import 'package:pickupexpress/screens/deliverypersonsignup_screen.dart';
import 'package:pickupexpress/screens/get_otp.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _phoneController = TextEditingController();

  Future<void> sendOtp(String phone_no) async {
    const String backendUrl = 'http://10.0.2.2:8000/send_otp';
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_no": phone_no}),
      );

      if (response.statusCode == 200) {
        print("OTP sent successfully");
      } else {
        print("Failed to send OTP: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1049),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _phoneController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter Phone Number",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
                  onPressed: () async {
                    String phone_no = _phoneController.text.trim();
                    if (phone_no.isNotEmpty) {
                      // Send OTP
                      await sendOtp(phone_no);
                      // Navigate to OTP screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(phone_no: phone_no),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter your phone number.")),
                      );
                    }
                  },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Get OTP"),
            ),
            SizedBox(height: 40),
            SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: "Are you a Delivery Person? ",
                  style: const TextStyle(
                      color: Colors.white),
                  children: [
                    TextSpan(
                      text: "Signup",
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ), 
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                 DeliverypersonsignupScreen(), 
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
