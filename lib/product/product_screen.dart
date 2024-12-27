import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  final String categoryName;
  final List products; // Get the list of products

  ProductScreen({required this.categoryName, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return _buildProductCard(
            context,
            product['name'],
            product['image'],
            product['price'],
          );
        },
      ),
    );
  }

  // Build each product card
  Widget _buildProductCard(
    BuildContext context,
    String name,
    String image,
    double price,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.asset(image, width: 60, height: 60),
        title: Text(name),
        subtitle: Text('\$${price.toString()}'),
        onTap: () {
          // Add product details view if needed
        },
      ),
    );
  }
}
