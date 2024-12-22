import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/selectmode_screen.dart';

class ReceiverDetails extends StatefulWidget {
  const ReceiverDetails({super.key});

  @override
  State<ReceiverDetails> createState() => _ReceiverDetailsState();
}

class _ReceiverDetailsState extends State<ReceiverDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _recivername;
  String? _reciveraddress;
  String? _pincode;
  String? _receiverphonenumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: const Color(0xFF1F1049),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Details for shipping",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

           
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        const Text(
                          "RECIEVER NAME",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter name";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _recivername= value;
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text("RECIEVER ADDRESS", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter receiver address",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter address";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _reciveraddress = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        
                      

                       const Text("PINCODE", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter pincode",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a pincode";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _pincode = value;
                          },
                        ),
                        const SizedBox(height: 30),
                         const Text("RECIEVER MOBILE NUMBER", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter phonenumber",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter phonenumber";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _receiverphonenumber = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Submit Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();  
                                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Selectmode(),
          ),
        );                           
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1F1049),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
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
