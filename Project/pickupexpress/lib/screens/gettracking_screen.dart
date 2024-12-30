import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class TrackingPage extends StatefulWidget {
  final int orderId;

  const TrackingPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  String _location = "Loading...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocation(widget.orderId);
  }

  Future<void> fetchLocation(int orderId) async {
    final uri = Uri.http('10.0.2.2:8000', '/user/orders/track', {'order_id': orderId.toString()});

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _location = data['current_location'] ?? "Location not available";
          _isLoading = false;
        });
      } else {
        setState(() {
          _location = "Failed to fetch location";
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _location = "Error fetching location";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking"),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Text("Current Location: $_location"),
      ),
    );
  }
}
