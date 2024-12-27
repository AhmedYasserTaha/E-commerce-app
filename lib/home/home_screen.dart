import 'package:e_commerce_app/auth/start_screen.dart';
import 'package:e_commerce_app/cart/cart_screen.dart';
import 'package:e_commerce_app/product/product_screen.dart';
import 'package:e_commerce_app/profile/profile_screen.dart';
import 'package:e_commerce_app/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './categories_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bannerImages = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  final List<Map<String, dynamic>> featuredProducts = [
    {
      'image': 'assets/images/1.jpg',
      'name': 'Product 1',
      'price': 29.99,
      'quantity': 1,
      'rating': 4.5
    },
    {
      'image': 'assets/images/2.jpg',
      'name': 'Product 2',
      'price': 49.99,
      'quantity': 1,
      'rating': 4.0
    },
    {
      'image': 'assets/images/3.jpg',
      'name': 'Product 3',
      'price': 19.99,
      'quantity': 1,
      'rating': 3.5
    },
    {
      'image': 'assets/images/4.jpg',
      'name': 'Product 4',
      'price': 39.99,
      'quantity': 1,
      'rating': 4.8
    },
  ];

  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.kMainColor,
        title: Text('Hello, ${widget.userName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(cartItems: cartItems),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen(userName: widget.userName),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app), // أيقونة تسجيل الخروج
            onPressed: _logout, // الاتصال بدالة تسجيل الخروج
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                scrollPhysics: BouncingScrollPhysics(),
              ),
              items: bannerImages.map((image) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoriesScreen(),
                            ),
                          );
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildCategoryItems(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: featuredProducts.length,
                    itemBuilder: (context, index) {
                      return _buildFeaturedProductCard(
                        featuredProducts[index]['image'],
                        featuredProducts[index]['name'],
                        featuredProducts[index]['price'],
                        featuredProducts[index]['quantity'],
                        featuredProducts[index]['rating'],
                        index,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // إزالة حالة تسجيل الدخول
    FirebaseAuth.instance.signOut(); // تسجيل الخروج من Firebase

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => StartScreen()),
    );
  }

  List<Widget> _buildCategoryItems() {
    final categories = [
      {'icon': Icons.laptop, 'name': 'Electronics'},
      {'icon': Icons.phone_iphone, 'name': 'Phone'},
      {'icon': Icons.person, 'name': 'Fashion'},
      {'icon': Icons.sports_soccer, 'name': 'Sports'},
      {'icon': Icons.headset_mic, 'name': 'Head Phone'},
      {'icon': Icons.games_outlined, 'name': 'Games'},
      {'icon': Icons.directions_car, 'name': 'Car'},
      {'icon': Icons.chair, 'name': 'Furniture'},
    ];

    return categories.map((category) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductScreen(
                categoryName: '', products: [],
                // Pass the products list
              ),
            ),
          );
          // التنقل إلى قائمة المنتجات في هذه الفئة
        },
        child: Container(
          width: 80,
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColor.kMainColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: AppColor.kMainColor,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                category['name'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFeaturedProductCard(String imagePath, String name, double price,
      int quantity, double rating, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cartItems.add({
            'image': imagePath,
            'name': name,
            'price': price,
            'quantity': 1,
          });
        });
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        '$rating',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
