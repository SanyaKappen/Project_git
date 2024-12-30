import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/receiver_details.dart';


class SenderDetails extends StatefulWidget {
 
  const SenderDetails({
    
    super.key});

  @override
  State<SenderDetails> createState() => _SenderDetailsState();
}

class _SenderDetailsState extends State<SenderDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _sender_name;
  String? _sender_phoneno;
  String? _pickup_location;
  String? _sender_pincode;
  String? _package_size;
  String? _package_type;

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
                           const Text(
                            "NAME",
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
                              _sender_name = value;
                            },
                          ),
                          const SizedBox(height: 20),
                           const Text(
                            "PHONE NUMBER",
                            style: TextStyle(fontSize: 16),
                          ),
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
                              _sender_phoneno = value;
                            },
                          ),
                          const SizedBox(height: 20),
                         
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
                              _pickup_location = value;
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
                              _sender_pincode = value;
                            },
                          ),
                          const SizedBox(height: 20),
          
                         
                          const Text("PACKAGE SIZE", style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              hintText: "package size",
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
                                _package_size = value;
                              });
                            },
                            onSaved: (value) {
                              _package_size = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text("PACKAGE TYPE", style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              hintText: "package Type",
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
                                _package_type = value;
                              });
                            },
                            onSaved: (value) {
                              _package_type = value;
                            },
                          ),
                          const SizedBox(height: 30),
          
                    
                          Center(
                            child: ElevatedButton(
                              onPressed: ()  async {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                 Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ReceiverDetails(
                          sender_name: _sender_name!,
                          sender_phoneno: _sender_phoneno!,
                          pickup_location: _pickup_location!,
                          sender_pincode: _sender_pincode!,
                          package_size: _package_size!,
                          package_type: _package_type!)),
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
