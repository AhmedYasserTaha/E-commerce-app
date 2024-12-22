import 'dart:async';

import 'package:e_commerce_app/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double ballY = 0;
  double widthVal = 50;
  double heightVal = 50;
  double bottomVal = 500;
  bool add = false;
  bool showShadow = false;
  int times = 0;
  bool showText = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // إعداد الـ Animation Controller مع منحنى مرن
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _controller.addListener(() {
      if (add) {
        ballY += 15; // زيادة الحركة لتصبح أكثر سلاسة
      } else {
        ballY -= 15;
      }
      if (ballY <= -200) {
        times += 1;
        add = true;
        showShadow = true;
      }
      if (ballY >= 0) {
        add = false;
        showShadow = false;
        widthVal += 50; // زيادة الحجم بشكل تدريجي
        heightVal += 50;
        bottomVal -= 200; // تحريك الصورة بشكل أسرع
      }
      if (times == 3) {
        showShadow = false;

        Timer(const Duration(milliseconds: 300), () {
          setState(() {
            showText = true;
          });
        });
        _controller.stop();
        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        });
      }
      setState(() {});
    });

    // بدء الـ Animation
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    widthVal = screenWidth * 0.5; // ضبط عرض الصورة بناءً على عرض الشاشة
    heightVal = screenHeight * 0.3; // ضبط ارتفاع الصورة بناءً على ارتفاع الشاشة

    return Scaffold(
      backgroundColor: const Color(0xff77cbd2),
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // تحريك الصورة بشكل تدريجي للوسط
            AnimatedPositioned(
              bottom: bottomVal,
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  Transform.translate(
                    offset: Offset(0, ballY),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: times == 3 ? 1 : 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: widthVal,
                        height: heightVal,
                        child: Image.asset(
                          "assets/images/buy.png", // هنا تضع اسم الصورة التي تريدها
                          fit: BoxFit.cover, // لضبط الصورة داخل المساحة
                        ),
                      ),
                    ),
                  ),
                  if (showShadow)
                    Container(
                      width: 50,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.2),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                ],
              ),
            ),
            // النص الذي يظهر تحت الصورة بعد انتهاء الأنيميشن
            if (showText)
              Positioned(
                bottom: screenHeight * 0.3, // استخدام نسبة من ارتفاع الشاشة
                child: Text(
                  'E-Commerce App', // النص المطلوب
                  style: GoogleFonts.abyssinicaSil(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
