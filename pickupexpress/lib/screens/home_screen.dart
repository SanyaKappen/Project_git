import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Container(
              color: Color(0xFF1F1049),
              child: Column(
              children: [
            
                Image.asset("assets/icon2.png"),
                Text("Quick, reliable, and always on time—order now!",style: TextStyle(color: Colors.white),),
                SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () {
                       Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryScreen(),
            ),
                    );                           
             
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
            ) 
            
                    ),
          ),
      ),
    );
  }
}