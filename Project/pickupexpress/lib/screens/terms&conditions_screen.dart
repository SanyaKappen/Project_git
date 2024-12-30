import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
        backgroundColor: const Color(0xFF1F1049),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to PickupExpress! By using our application, you agree to comply with and be bound by the following Terms & Conditions. Please read these terms carefully before using the service.\n',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                '1. General Terms\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '1.1 This application is designed for facilitating the booking and delivery of packages.\n'
                '1.2 By accessing or using our services, you confirm that you are at least 18 years old or have the consent of a legal guardian.\n'
                '1.3 All services are subject to availability, and we reserve the right to refuse service to anyone at our discretion.\n',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                '2. User Responsibilities\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '2.1 You are responsible for providing accurate, complete, and up-to-date information during the order process.\n'
                '2.2 You must ensure that all items for delivery comply with our prohibited items policy (refer to Section 6).\n'
                '2.3 You agree to pay the charges for the services as displayed during the booking process.\n',
                style: TextStyle(fontSize: 16),
              ),
              // Add all other sections in the same format as above.
              const Text(
                '3. Payment Terms\n',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '3.1 Payment for services must be made in full before the delivery process begins.\n'
                '3.2 All payments are final, and refunds will only be provided as per our cancellation and refund policy (refer to Section 5).\n'
                '3.3 We are not responsible for additional charges incurred due to payment failures or delays caused by third-party payment gateways.\n',
                style: TextStyle(fontSize: 16),
              ),
              // Continue adding the rest of the terms...
              const SizedBox(height: 20),
              Text(
                'For more information, please contact support@pickupexpress.com.',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}