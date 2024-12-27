import 'package:e_commerce_app/auth/sing_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // أضف هذه المكتبة
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/home/home_screen.dart';
import 'package:e_commerce_app/widget/app_color.dart';
import 'package:e_commerce_app/widget/custom_text_field.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool rememberMe = false; // متغير لحفظ حالة التذكر

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    _loadRememberMe();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadRememberMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return; // التحقق من حالة Widget

      setState(() {
        rememberMe = prefs.getBool('rememberMe') ?? false;
        if (rememberMe) {
          emailController.text = prefs.getString('email') ?? '';
          passwordController.text = prefs.getString('password') ?? '';
        }
      });
    } catch (e) {
      print('Error loading preferences: $e');
      // يمكنك إضافة معالجة الخطأ هنا
    }
  }

  _saveRememberMe() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('rememberMe', rememberMe);
      if (rememberMe) {
        await prefs.setString('email', emailController.text);
        await prefs.setString('password', passwordController.text);
      } else {
        await prefs.remove('email');
        await prefs.remove('password');
      }
    } catch (e) {
      print('Error saving preferences: $e');
      // يمكنك إضافة معالجة الخطأ هنا
    }
  }

  _saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // تخزين حالة تسجيل الدخول
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kMainColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const Gap(50),
                Image.asset("assets/images/buy.png"),
                const Gap(50),
                Center(
                  child: Text(
                    "Login",
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
                          controller: emailController,
                          hintText: "Enter Your Email",
                          icon: Icons.email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            } else if (!RegExp(r'\S+@\S+\.\S+')
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const Gap(30),
                        CustomFormField(
                          controller: passwordController,
                          hintText: "Enter Password",
                          icon: Icons.password,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const Gap(30),
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              "Remember Me",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(50),
                WidgetBottom(
                  text: "Login",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        // تسجيل الدخول باستخدام Firebase
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );

                        // الحصول على المستخدم الحالي
                        User? user = userCredential.user;

                        // الحصول على اسم المستخدم أو عرض اسم افتراضي
                        String userName = user?.displayName ?? "Guest";

                        // حفظ حالة تسجيل الدخول
                        await _saveLoginStatus();
                        await _saveRememberMe();

                        // التوجيه إلى HomeScreen مع تمرير اسم المستخدم
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen(userName: userName),
                          ),
                        );

                        // عرض رسالة نجاح
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Logged in successfully')),
                        );
                      } on FirebaseAuthException catch (e) {
                        // التعامل مع أخطاء تسجيل الدخول
                        String errorMessage;
                        if (e.code == 'user-not-found') {
                          errorMessage = 'No user found for that email.';
                        } else if (e.code == 'wrong-password') {
                          errorMessage = 'Wrong password provided.';
                        } else {
                          errorMessage = 'An error occurred. Please try again.';
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      } catch (e) {
                        // التعامل مع الأخطاء غير المتوقعة
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('An unexpected error occurred: $e')),
                        );
                      } finally {
                        // إيقاف مؤشر التحميل
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                ),
                const Gap(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SingUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign up",
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
          if (isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: RotationTransition(
                  turns: _controller,
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/images/buy.png"),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
