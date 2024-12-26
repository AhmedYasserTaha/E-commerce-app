import 'package:e_commerce_app/widget/app_color.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  // بيانات المنتجات (صور وأسعار)
  final List<Map<String, dynamic>> featuredProducts = [
    {'image': 'assets/images/1.jpg', 'price': 29.99},
    {'image': 'assets/images/2.jpg', 'price': 49.99},
    {'image': 'assets/images/3.jpg', 'price': 19.99},
    {'image': 'assets/images/4.jpg', 'price': 39.99},
    {'image': 'assets/images/1.jpg', 'price': 29.99},
    {'image': 'assets/images/2.jpg', 'price': 49.99},
    {'image': 'assets/images/3.jpg', 'price': 19.99},
    {'image': 'assets/images/4.jpg', 'price': 39.99},
    {'image': 'assets/images/1.jpg', 'price': 29.99},
    {'image': 'assets/images/2.jpg', 'price': 49.99},
    {'image': 'assets/images/3.jpg', 'price': 19.99},
    {'image': 'assets/images/4.jpg', 'price': 39.99},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.kMainColor,
        title: Text('Welcome, ${widget.userName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // التنقل إلى سلة التسوق
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // التنقل إلى صفحة الملف الشخصي
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
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

            // Categories Section
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

            // Featured Products
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
                    itemCount: featuredProducts.length, // عدد المنتجات
                    itemBuilder: (context, index) {
                      // تمرير الصورة والسعر لكل منتج
                      return _buildFeaturedProductCard(
                        featuredProducts[index]['image'],
                        featuredProducts[index]['price'],
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

  List<Widget> _buildCategoryItems() {
    final categories = [
      {'icon': Icons.laptop, 'name': 'Electronics'},
      {'icon': Icons.chair, 'name': 'Furniture'},
      {'icon': Icons.person, 'name': 'Fashion'},
      {'icon': Icons.sports_basketball, 'name': 'Sports'},
      {'icon': Icons.book, 'name': 'Books'},
    ];

    return categories.map((category) {
      return GestureDetector(
        onTap: () {
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

  Widget _buildFeaturedProductCard(String imagePath, double price) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
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
                const Text(
                  'Product Name',
                  style: TextStyle(
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
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      '4.5',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
