import 'package:e_commerce_app/auth/start_screen.dart';
import 'package:e_commerce_app/home/home_screen.dart';
import 'package:e_commerce_app/auth/login_screen.dart';
import 'package:e_commerce_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Ui',
      debugShowCheckedModeBanner: false,
      home: SplashScreenHandler(),
    );
  }
}

class SplashScreenHandler extends StatelessWidget {
  const SplashScreenHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // التأكد من حالة تسجيل الدخول أولًا، ثم استرجاع اسم المستخدم
          if (snapshot.data == true) {
            return FutureBuilder<String>(
              future: _getUserName(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else if (userSnapshot.hasError) {
                  return Center(child: Text('Error: ${userSnapshot.error}'));
                } else {
                  String userName = userSnapshot.data ?? "Guest";
                  return HomeScreen(userName: userName);
                }
              },
            );
          } else {
            return const SplashScreen();
          }
        }
      },
    );
  }

  // دالة للتحقق من حالة تسجيل الدخول
  Future<bool> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // دالة لاسترجاع اسم المستخدم
  Future<String> _getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? "Guest";
  }
}
