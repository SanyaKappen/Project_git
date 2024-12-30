import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:pickupexpress/screens/terms&conditions_screen.dart';

class ConfirmationScreen extends StatefulWidget {
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

  const ConfirmationScreen(
      {
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
      Key? key})
      : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  String _mode = "Standard"; // Default mode is "Standard"
  String _price = "0.00";
  String _pickup_date = "Not Calculated";
  String _delivery_date = "Not Calculated";
  String _userId = ""; // Declare the userId

  @override
  void initState() {
    super.initState();
    _loadUserId();  // Load userId from Hive when the screen initializes
    _calculatePriceAndDates(mode: "standard");
  }

  // Method to load userId from Hive
  Future<void> _loadUserId() async {
    var box = await Hive.openBox('userBox');
    setState(() {
      _userId = box.get('userId', defaultValue: ""); // Retrieve userId, default to an empty string if not found
    });
  }

 Future<void> _calculatePriceAndDates({required String mode}) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/calculate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'package_size': widget.package_size,
        'package_type': widget.package_type,
        'mode': mode.toLowerCase().replaceAll(' ', '_'),
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _price = data['price'].toString();
        _pickup_date = data['pickup_date'];
        _delivery_date = data['delivery_date'];
      });
    } else {
      // Handle error if needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to calculate price. Please try again.')),
      );
    }
  }

Future<void> _submitOrder() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/order_details'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sender_name': widget.sender_name,
        'sender_phoneno': widget.sender_phone_no,
        'pickup_location': widget.pickup_location,
        'package_type': widget.package_type,
        'package_size': widget.package_size,
        'sender_pincode': widget.sender_pincode,
        'mode': _mode.toLowerCase().replaceAll(' ', '_'),
        'receiver_name': widget.receiver_name,
        'receiver_address': widget.receiver_address,
        'price': _price,
        'receiver_pincode': widget.receiver_pincode,
        'receiver_phoneno': widget.receiver_phoneno,
        'pickup_date': _pickup_date,
        'delivery_date': _delivery_date,
        'user_id': _userId,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle successful order confirmation (show a success message, navigate, etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed successfully!')),
      );
      // Optionally navigate to another screen or reset the form.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to place order. Please try again.')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1049),
        title: const Text(
          'Send Package',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailsRow("${widget.sender_name}.", "${widget.sender_phone_no}\n${widget.pickup_location}"),
            _buildDetailsRow("${widget.receiver_name}.", "${widget.receiver_phoneno}\n${widget.receiver_address}"),
            _buildDetailsRow("Package Details:\n", "${widget.package_type} . ${widget.package_size}"),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "Select Mode: ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _mode,
                  onChanged: (String? newMode) {
                    setState(() {
                      _mode = newMode!; // Update the selected mode
                    });
                    _calculatePriceAndDates(mode: newMode!.toLowerCase().replaceAll(' ', '_'));
                  },
                  items: <String>['Standard', 'Eco', 'Express']
                      .map<DropdownMenuItem<String>>((String mode) {
                    return DropdownMenuItem<String>(
                      value: mode,
                      child: Text(mode),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailsRow("Price: ", _price),
            _buildDetailsRow("Pickup Date: ", _pickup_date),
            _buildDetailsRow("Delivery Date: ", _delivery_date),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _submitOrder,            
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F1049),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
           const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigate to the Terms & Conditions screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsAndConditionsScreen()),
                  );
                },
                child: const Text(
                  "By proceeding you agree to our Terms & Conditions",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsRow(String title, String details) {
    List<String> lines = details.split('\n'); // Split into lines

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lines[0], // First line (e.g., name or phone number)
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                if (lines.length > 1) // Only display the second line if it exists
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      lines[1], // Second part (e.g., address)
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}