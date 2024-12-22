import 'package:flutter/material.dart';
class ConfirmationPage extends StatelessWidget {
  final String pickupLocation;
  final String pincode;
  final String parcelSize;
  final String parcelType;
  final String deliveryMode;

  const ConfirmationPage({
    super.key,
    required this.pickupLocation,
    required this.pincode,
    required this.parcelSize,
    required this.parcelType,
    required this.deliveryMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1049),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1049),
        title: const Text("Confirmation", style: TextStyle(color: Colors.white)),
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
              "Shipping Details",
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text("Pickup Location: $pickupLocation", style: const TextStyle(color: Colors.white)),
            Text("Pincode: $pincode", style: const TextStyle(color: Colors.white)),
            Text("Parcel Size: $parcelSize", style: const TextStyle(color: Colors.white)),
            Text("Parcel Type: $parcelType", style: const TextStyle(color: Colors.white)),
            Text("Delivery Mode: $deliveryMode", style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Proceed to payment
              },
              child: const Text("Proceed with Payment"),
            ),
          ],
        ),
      ),
    );
  }
}