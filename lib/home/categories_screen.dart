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
          return _buildCategoryCard(
            context,
            categories[index]['icon'] as IconData,
            categories[index]['name'] as String,
            categories[index]['itemCount'] as int,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    IconData icon,
    String name,
    int itemCount,
  ) {
    return GestureDetector(
      onTap: () {
        // التنقل إلى قائمة المنتجات في هذه الفئة
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
                '$itemCount items',
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

  final List<Map<String, dynamic>> categories = [
    {
      'icon': Icons.laptop,
      'name': 'Electronics',
      'itemCount': 120,
    },
    {
      'icon': Icons.chair,
      'name': 'Furniture',
      'itemCount': 85,
    },
    {
      'icon': Icons.person,
      'name': 'Fashion',
      'itemCount': 250,
    },
    {
      'icon': Icons.sports_basketball,
      'name': 'Sports',
      'itemCount': 65,
    },
    {
      'icon': Icons.book,
      'name': 'Books',
      'itemCount': 180,
    },
    {
      'icon': Icons.watch,
      'name': 'Accessories',
      'itemCount': 95,
    },
  ];
}
