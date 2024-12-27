import 'package:e_commerce_app/product/product_screen.dart';
import 'package:e_commerce_app/widget/app_color.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: AppColor.kMainColor,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return buildCategoryCard(
            context,
            categories[index]['icon'] as IconData,
            categories[index]['name'] as String,
            categories[index]['products'] as List, // Pass products data
          );
        },
      ),
    );
  }

  // Build each category card
  Widget buildCategoryCard(
    BuildContext context,
    IconData icon,
    String name,
    List products, // Pass product list
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to product screen with category data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(
              categoryName: name,
              products: products, // Pass the products list
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.kMainColor.withOpacity(0.7),
                AppColor.kMainColor,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '${products.length} items',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Example of categories with products data
  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.laptop,
      'name': 'Electronics',
      'products': [
        {'name': 'Laptop', 'image': 'assets/images/3.jpg', 'price': 1000.0},
        {'name': 'Headphones', 'image': 'assets/images/3.jpg', 'price': 150.0},
        // Add more products
      ],
    },
    {
      'icon': Icons.phone_iphone,
      'name': 'Phone',
      'products': [
        {'name': 'T-shirt', 'image': 'assets/images/5.jpg', 'price': 20.0},
        {'name': 'Jeans', 'image': 'assets/images/5.jpg', 'price': 30.0},
        // Add more products
      ],
    },

    {
      'icon': Icons.person,
      'name': 'Fashion',
      'products': [
        {'name': 'T-shirt', 'image': 'assets/images/5.jpg', 'price': 20.0},
        {'name': 'Jeans', 'image': 'assets/images/5.jpg', 'price': 30.0},
        // Add more products
      ],
    },
    {
      'icon': Icons.sports_soccer,
      'name': 'Sports',
      'products': [
        {'name': 'T-shirt', 'image': 'assets/images/5.jpg', 'price': 20.0},
        {'name': 'Jeans', 'image': 'assets/images/5.jpg', 'price': 30.0},
        // Add more products
      ],
    },
    {
      'icon': Icons.headset_mic,
      'name': 'Head Phone',
      'products': [
        {'name': 'T-shirt', 'image': 'assets/images/5.jpg', 'price': 20.0},
        {'name': 'Jeans', 'image': 'assets/images/5.jpg', 'price': 30.0},
        // Add more products
      ],
    },
    {
      'icon': Icons.games_outlined,
      'name': 'Games',
      'products': [
        {'name': 'T-shirt', 'image': 'assets/images/5.jpg', 'price': 20.0},
        {'name': 'Jeans', 'image': 'assets/images/5.jpg', 'price': 30.0},
        // Add more products
      ],
    },
    {
      'icon': Icons.directions_car,
      'name': 'Car',
      'products': [
        {'name': 'T-shirt', 'image': 'assets/images/5.jpg', 'price': 20.0},
        {'name': 'Jeans', 'image': 'assets/images/5.jpg', 'price': 30.0},
        // Add more products
      ],
    },

    {
      'icon': Icons.chair,
      'name': 'Furniture',
      'products': [
        {'name': 'Sofa', 'image': 'assets/images/4.jpg', 'price': 500.0},
        {'name': 'Chair', 'image': 'assets/images/4.jpg', 'price': 80.0},
        // Add more products
      ],
    },

    // Add more categories here
  ];
}
