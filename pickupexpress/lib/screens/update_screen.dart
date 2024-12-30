import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderUpdatePage extends StatefulWidget {
  const OrderUpdatePage({Key? key}) : super(key: key);

  @override
  State<OrderUpdatePage> createState() => _OrderUpdatePageState();
}

class _OrderUpdatePageState extends State<OrderUpdatePage> {
  final TextEditingController _locationController = TextEditingController();
  bool _orderDelivered = false;

 Future<void> _submitOrderUpdate() async {
    String location = _locationController.text;
    bool delivered = _orderDelivered;

    final Map<String, dynamic> trackingData = {
      'status': delivered ? 'Delivered' : 'In Progress',
      'current_location': location,
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/track'),  
      headers: {'Content-Type': 'application/json'},
      body: json.encode(trackingData),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order Update Successful: ${responseData['status']}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update order.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1F1049),
        title: const Text(
          "Current Orders",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order1",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Current Order Location Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const Text(
                    "Current Order Location",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 200),
                    child: TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        hintText: "write....",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Update Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Update Button
                  String location = _locationController.text;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Location Updated: $location")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F1049),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Order Delivered Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _orderDelivered,
                    onChanged: (bool? value) {
                      setState(() {
                        _orderDelivered = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    "Order Delivered",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Submit Button
                  String location = _locationController.text;
                  bool delivered = _orderDelivered;
                  String message = delivered
                      ? "Order delivered and location updated."
                      : "Location updated, order not yet delivered.";
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1F1049),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
