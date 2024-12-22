import 'package:flutter/material.dart';

class UserSignupScreen extends StatelessWidget {
  const UserSignupScreen({super.key});

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
                  child: const TextField(
                    style: TextStyle(
                  color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {},
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
