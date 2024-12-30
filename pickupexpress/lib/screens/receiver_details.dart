// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/selectmode_screen.dart';

class ReceiverDetails extends StatefulWidget {
  final String sender_name;
  final String sender_phoneno;
  final String pickup_location;
  final String sender_pincode;
   final String package_size;
   final String package_type;

    const ReceiverDetails({
    required this.sender_name,
    required this.sender_phoneno, 
    required this.pickup_location,
    required this.sender_pincode,
    required this.package_size,
    required this.package_type,
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiverDetails> createState() => _ReceiverDetailsState();
}

class _ReceiverDetailsState extends State<ReceiverDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _receiver_name;
  String? _receiver_address;
  String? _receiver_pincode;
  String? _receiver_phoneno;
 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                             _receiver_name = value;
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
                              _receiver_address = value;
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
                              _receiver_pincode = value;
                            },
                          ),
                          const SizedBox(height: 30),
                           const Text("RECEIVER MOBILE NUMBER", style: TextStyle(fontSize: 16)),
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
                              _receiver_phoneno = value;
                            },
                          ),
                          const SizedBox(height: 20),
          
                         
                          Center(
                            child: ElevatedButton(
                             onPressed: () async {
                                if (_formKey.currentState?.validate() ?? false) {
                                  _formKey.currentState?.save();
          
                                 
                                    // Navigate to the next screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) =>  SelectModeScreen(
                          sender_name: widget.sender_name,
                          sender_phone_no: widget.sender_phoneno,
                          pickup_location: widget.pickup_location,
                          sender_pincode: widget.sender_pincode,
                          package_size: widget.package_size,
                          package_type: widget.package_type,
                          receiver_name: _receiver_name!,
                          receiver_address: _receiver_address!,
                          receiver_pincode: _receiver_pincode!,
                          receiver_phoneno: _receiver_phoneno!
                          
                          )),
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
      ),
    );
  }
}
