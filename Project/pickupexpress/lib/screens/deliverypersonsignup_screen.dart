import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pickupexpress/screens/get_otp.dart';
import 'dart:convert';


class DeliverypersonsignupScreen extends StatelessWidget {
    DeliverypersonsignupScreen({super.key});
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _vehicleNumberController = TextEditingController();
    final TextEditingController _adhaarNumberController = TextEditingController();
    final TextEditingController _licenceNumberController = TextEditingController();

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
  Future<bool> signupUser(BuildContext context) async {
    final String name = _nameController.text;
    final String phone_no = _phoneController.text;
    final String vehicle_no = _vehicleNumberController.text;
    final String adhaar_no = _adhaarNumberController.text;
    final String licence_no = _licenceNumberController.text;

   
    if (name.isEmpty || phone_no.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return false;
    }

    try {
      final url = Uri.parse(
          'http://10.0.2.2:8000/deliveryperson_signup'); 
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'phone_no': phone_no, 'vehicle_no': vehicle_no, 'adhaar_no': adhaar_no , 'licence_no': licence_no}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup successful!")),
        );
        return true; // Indicate success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed: ${response.body}")),
        );
        return false; 
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $error")),
      );
      return false; // Indicate failure
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1049),
      body: Center(
        child: SafeArea(
          child: Container(
            color: Color(0xFF1F1049),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 60),
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _vehicleNumberController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Vehicle number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _adhaarNumberController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Aadhaar number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _licenceNumberController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "License Number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
