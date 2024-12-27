import 'package:e_commerce_app/home/home_screen.dart';
import 'package:e_commerce_app/widget/app_color.dart';
import 'package:e_commerce_app/auth/login_screen.dart';
import 'package:e_commerce_app/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد SharedPreferences

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen>
    with SingleTickerProviderStateMixin {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.kMainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(50),
            Image.asset("assets/images/buy.png"),
            const Gap(50),
            Center(
              child: Text(
                "SignUp",
                style: GoogleFonts.abyssinicaSil(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Gap(50),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomFormField(
                      controller: name,
                      hintText: "Enter Your Name",
                      icon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                    const Gap(30),
                    CustomFormField(
                      controller: email,
                      hintText: "Enter Your Email",
                      icon: Icons.email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const Gap(30),
                    CustomFormField(
                      controller: password,
                      hintText: "Enter Password",
                      icon: Icons.password,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    const Gap(30),
                    CustomFormField(
                      controller: confirmPassword,
                      hintText: "confirmPassword",
                      icon: Icons.password,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    const Gap(30),
                  ],
                ),
              ),
            ),
            const Gap(50),
            WidgetBottom(
              text: "Sign Up",
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _showLoadingDialog(context); // عرض التحميل

                  try {
                    await createAccount(context);

                    // إغلاق الـ dialog عند النجاح
                    Navigator.of(context).pop();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(userName: name.text),
                      ),
                    );
                  } catch (e) {
                    Navigator.of(context).pop(); // إغلاق الـ dialog عند الخطأ
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${e.toString()}')),
                    );
                  }
                }
              },
            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: RotationTransition(
          turns: _controller,
          child: Image.asset(
            "assets/images/buy.png",
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }

  // دالة لحفظ حالة تسجيل الدخول
  Future<void> _saveLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // تخزين حالة تسجيل الدخول
  }

  Future<void> createAccount(BuildContext context) async {
    try {
      // إنشاء حساب جديد
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // الحصول على المستخدم الحالي وتحديث اسمه
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updateDisplayName(name.text);

      // حفظ اسم المستخدم وحالة الدخول
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userName', name.text);
      await prefs.setBool('isLoggedIn', true); // تخزين حالة تسجيل الدخول

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signed up successfully!')),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }
}
