import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pickupexpress/screens/home_screen.dart';


class AdminsignupScreen extends StatelessWidget {
  AdminsignupScreen({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<bool> signupUser(BuildContext context) async {
    final String name = _nameController.text;
    final String phone_no = _phoneController.text;

  
    if (name.isEmpty || phone_no.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return false;
    }

    try {
      final url = Uri.parse(
          'http://10.0.2.2:8000/admin_signup'); 
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'phone_no': phone_no}),
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
        return false; // Indicate failure
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
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1049),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SafeArea(
          child: Container(
            color: Color(0xFF1F1049),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: TextField(
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                    final bool signupSuccess = await signupUser(context);
                    if (signupSuccess) {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomeScreen()),
                      // );
                    }
                  },
                  child: const Text("Get Started"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
