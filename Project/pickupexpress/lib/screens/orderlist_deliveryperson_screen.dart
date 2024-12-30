import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pickupexpress/screens/ordercard_screen.dart';

class OrderlistDeliveryperson extends StatefulWidget {
  final String vehicleType; // Electric or Other
  const OrderlistDeliveryperson({Key? key, required this.vehicleType}) : super(key: key);

  @override
  _OrderlistDeliverypersonState createState() => _OrderlistDeliverypersonState();
}

class _OrderlistDeliverypersonState extends State<OrderlistDeliveryperson> {
  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = fetchDeliveryOrders(widget.vehicleType);
  }

  Future<List<Order>> fetchDeliveryOrders(String vehicleType) async {
    final uri = Uri.http('192.168.107.45:8000', '/delivery/orders', {
      'vehicle_type': vehicleType,
    });
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load delivery orders');
    }
  }

  Future<void> handleOrderAction(String action, int orderId) async {
    final uri = Uri.http('192.168.107.45:8000', '/delivery/order/action');
    final response = await http.post(
      uri,
      body: jsonEncode({'order_id': orderId, 'action': action}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order $action successfully.')),
      );
      setState(() {
        _ordersFuture = fetchDeliveryOrders(widget.vehicleType); // Refresh orders
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to $action order.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Orders"),
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders available.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(
                  order: order,
                  onAccept: () => handleOrderAction("accept", order.id), // Accept action
                  onDecline: () => handleOrderAction("decline", order.id), // Decline action
                );
              },
            );
          }
        },
      ),
    );
  }
}