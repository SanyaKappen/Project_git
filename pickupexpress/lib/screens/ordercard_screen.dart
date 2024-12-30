import 'package:flutter/material.dart';
import 'package:pickupexpress/screens/gettracking_screen.dart';
class Order {
  final int id;
  final String sender_name;
  final String receiver_name;
  final String receiver_address;
  final double price;
  final String mode;
  final String pickup_date;
  final String delivery_date;

  Order({
    required this.id,
    required this.sender_name,
    required this.receiver_name,
    required this.receiver_address,
    required this.price,
    required this.mode,
    required this.pickup_date,
    required this.delivery_date,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      sender_name: json['sender_name'],
      receiver_name: json['receiver_name'],
      receiver_address: json['receiver_address'],
      price: json['price'],
      mode: json['mode'],
      pickup_date: json['pickup_date'],
      delivery_date: json['delivery_date'],
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;
  final bool showTrackButton;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const OrderCard({
    Key? key,
    required this.order,
    this.showTrackButton = false,
    this.onAccept,
    this.onDecline,
  }) : super(key: key);

  // Navigate to the TrackingPage
  Future<void> trackOrder(BuildContext context, int orderId) async {
    // Navigate to the TrackingPage using Navigator.push
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TrackingPage(orderId: orderId),
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the tracking page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrackingPage(orderId: order.id),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Text('Sender: ${order.sender_name}'),
              Text('Receiver: ${order.receiver_name}'),
              Text('Address: ${order.receiver_address}'),
              Text('Mode: ${order.mode}'),
              Text('Price: Rs. ${order.price.toStringAsFixed(2)}'),
              Text('Pickup: ${order.pickup_date}'),
              Text('Delivery: ${order.delivery_date}'),
              const SizedBox(height: 16.0),
              if (showTrackButton)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackingPage(orderId: order.id),
                      ),
                    );
                  },
                  child: const Text("Track Order"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}