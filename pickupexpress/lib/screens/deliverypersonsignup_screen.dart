import 'package:flutter/material.dart';

class DeliverypersonsignupScreen extends StatelessWidget {
  const DeliverypersonsignupScreen({super.key});

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
                    style: TextStyle(
                  color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(
                  color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(
                  color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Vehicle number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(
                  color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Aadhaar number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: TextStyle(
                  color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "License Number",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Get Started",style:TextStyle(
                      color: Colors.black
                    )),
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
      ),
    );
  }
}