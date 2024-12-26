import 'dart:async';

import 'package:e_commerce_app/auth/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double bottomVal = 500;
  bool showText = false;

  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // إعداد الأنيميشن لتدوير الصورة دورة كاملة (360 درجة)
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // بدء الأنيميشن
    _controller.forward();

    // الانتقال إلى الشاشة الرئيسية بعد انتهاء الأنيميشن
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          bottomVal = MediaQuery.of(context).size.height / 2 - 50; // وسط الشاشة
          showText = true;
        });

        Timer(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const StartScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff77cbd2),
      body: SizedBox(
        width: screenWidth,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // الصورة مع الدوران والتحريك
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              bottom: bottomVal,
              child: AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Image.asset(
                      "assets/images/buy.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            // النص الذي يظهر تحت الصورة
            if (showText)
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.3,
                child: Text(
                  'E-Commerce App',
                  style: GoogleFonts.abyssinicaSil(
                    fontSize: 28,
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
