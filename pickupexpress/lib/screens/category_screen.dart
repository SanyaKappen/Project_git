import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pickupexpress/screens/sender_details.dart';

class Category {
  final String name;
  final String iconPath;
  final List<String> items;

  Category({required this.name, required this.iconPath, required this.items});
}

class CategoryScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(
      name: "Automobiles",
      iconPath: "assets/automobiles.svg",
      items: [
        "Accessories, Parts, Ancillary, Tools, Navigation Devices, Oils, Fluids & Others"
      ],
    ),
    Category(
      name: "Packaged Food",
      iconPath: "assets/imagefood.svg",
      items: [
        "Packaged/Canned Food, Pet Supplies, Sports Supplements, Nutrition Products."
      ],
    ),
    Category(
      name: "Health & Wellness",
      iconPath: "assets/imagehealth.svg",
      items: [
        "Face Mask, Sanitizers, Gloves, Hospital & Medical Equipment, Medical Professional Supplies"
      ],
    ),
    Category(
      name: "Electronics",
      iconPath: "assets/electronic.svg",
      items: [
        "Printer, Monitors, TV, Headphones, Hard Drive, Mobiles, Fan, Computers, Others"
      ],
    ),
    Category(
      name: "Books & Stationery",
      iconPath: "assets/book-icon.svg",
      items: [
        "Books, Magazine, Office Supplies, Stationery Products, Board Games, Others"
      ],
    ),
    Category(
      name: "Documents",
      iconPath: "assets/document.svg",
      items: ["Forms, Catalogs, Papers, Others"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: const Color(0xFF1F1049),
        
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF1F1049),
                          width: 4), // Purple border
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Category list
                        Expanded(
                          child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryItem(category: categories[index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Order button inside the border
                        ElevatedButton(
                          onPressed: () {
                             Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SenderDetails(),
          ),
        );                           
           
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                                0xFF1F1049), // Dark purple background
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            "Order",
                            style: TextStyle(
                              color: Colors.white, // White text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              10), // Optional: rounded corners of the card
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            SvgPicture.asset(category.iconPath, height: 50, width: 50),
            SizedBox(height: 10),
            Text(
              category.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              category.items.join(", "),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
