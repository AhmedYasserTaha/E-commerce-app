import 'package:e_commerce_app/app_color.dart';
import 'package:e_commerce_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.kMainColor,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Gap(50),
            Image.asset("assets/images/buy.png"),
            const Gap(50),
            Center(
              child: Text(
                "Login",
                style: GoogleFonts.abyssinicaSil(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(50),
            const CustomTextField(
              hint: "Enter Your Email",
              icon: Icons.email,
            ),
            const Gap(30),
            const CustomTextField(hint: "Enter Password", icon: Icons.password),
            const Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor:
                      const Color.fromARGB(255, 0, 0, 0), // لون الخلفية
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // جعل الزر ذو أطراف دائرية
                  ),
                ),
                child: const Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dont have an account",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sing up",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ));
  }
}
