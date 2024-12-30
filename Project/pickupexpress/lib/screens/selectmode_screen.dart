import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pickupexpress/screens/confirmation_screen.dart';

class SelectModeScreen extends StatefulWidget {
  final String sender_name;
   final String sender_phone_no;
  final String pickup_location;
  final String sender_pincode;
  final String package_size;
  final String package_type;
  final String receiver_name;
  final String receiver_address;
  final String receiver_pincode;
  final String receiver_phoneno;

  const SelectModeScreen({
    required this.sender_name,
    required this.sender_phone_no,
    required this.pickup_location,
    required this.sender_pincode,
    required this.package_size,
    required this.package_type,
    required this.receiver_name,
    required this.receiver_address,
    required this.receiver_pincode,
    required this.receiver_phoneno,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
  String? selectedMode;
  Map<String, dynamic>? modeDetails;
  bool isLoading = false;

  final modes = [
    {
      'name': 'Eco mode',
      'image': 'assets/eco_mode.png',
    },
    {
      'name': 'Express mode',
      'image': 'assets/express_mode.png',
    },
    {
      'name': 'Standard',
      'image': 'assets/standard_delivery.jpg',
    },
  ];

  Future<void> fetchModeDetails(String mode) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/calculate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'package_size': widget.package_size,
          'package_type': widget.package_type,
          'mode': mode.toLowerCase().replaceAll(" ", "_"),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
            print(modeDetails);
          modeDetails = data;
        });
      } else {
        throw Exception('Failed to fetch details');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching mode details: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1049),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1049),
        title: const Text('Modes', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // List of modes with dynamic content
            Expanded(
              child: ListView(
                children: [
                  for (var mode in modes) ...[
                    ListTile(
                      title: Text(
                        mode['name']!,
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      leading: Image.asset(
                        mode['image']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                        onPressed: () async {
                          setState(() {
                            selectedMode = mode['name'];
                            print(mode['name']);
                          });
                          await fetchModeDetails(mode['name']!);
                        },
                      ),
                    ),
                    if (selectedMode == mode['name'] && modeDetails != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pickup Date: ${modeDetails!['pickup_date']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Delivery Date: ${modeDetails!['delivery_date']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Price: ₹${modeDetails!['price'].toStringAsFixed(0)}', 
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
            if (selectedMode != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmationScreen(
                          sender_name: widget.sender_name,
                          sender_phone_no: widget.sender_phone_no,
                          pickup_location: widget.pickup_location,
                          sender_pincode: widget.sender_pincode,
                          package_size: widget.package_size,
                          package_type: widget.package_type,
                          receiver_name: widget.receiver_name,
                          receiver_address: widget.receiver_address,
                          receiver_pincode: widget.receiver_pincode,
                          receiver_phoneno: widget.receiver_phoneno,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Got it', style: TextStyle(color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}