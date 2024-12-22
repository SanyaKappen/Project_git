import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/receiver_details.dart';

class SenderDetails extends StatefulWidget {
  const SenderDetails({super.key});

  @override
  State<SenderDetails> createState() => _SenderDetailsState();
}

class _SenderDetailsState extends State<SenderDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _pickupLocation;
  String? _pincode;
  String? _parcelSize;
  String? _parcelType;

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

                // Form Container
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
                        // Pickup Location
                        const Text(
                          "PICKUP LOCATION",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter pickup location",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a pickup location";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _pickupLocation = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Pincode
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
                        const SizedBox(height: 20),

                        // Parcel Size
                        const Text("PARCEL SIZE", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            hintText: "Parcel size",
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            'Extra small Package (Max. 500 gm)',
                            'Small Package (500 gm - 2 kg)',
                            'Medium Package (2 kg - 5 kg)',
                            'Large Package (5 kg - 10 kg)',
                          ]
                              .map((size) => DropdownMenuItem<String>(
                                    value: size,
                                    child: Text(size),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _parcelSize = value;
                            });
                          },
                          onSaved: (value) {
                            _parcelSize = value;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Parcel Type
                        const Text("PARCEL TYPE", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            hintText: "Parcel Type",
                            border: OutlineInputBorder(),
                          ),
                          items: [
                            'Automobiles',
                            'Packaged Food',
                            'Health & Wellness',
                            'Electronics',
                            'Books & Stationery',
                            'Documents',
                          ]
                              .map((type) => DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _parcelType = value;
                            });
                          },
                          onSaved: (value) {
                            _parcelType = value;
                          },
                        ),
                        const SizedBox(height: 30),

                        // Submit Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _formKey.currentState?.save();   
                                Navigator.push( context,
                              MaterialPageRoute(
                          builder: (context) => ReceiverDetails(),
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
