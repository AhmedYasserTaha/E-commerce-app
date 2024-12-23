import 'package:e_commerce_app/app_color.dart';
import 'package:e_commerce_app/home/login_screen.dart';
import 'package:e_commerce_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

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
                "SingUp",
                style: GoogleFonts.abyssinicaSil(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(50),
            const CustomTextField(
              hint: "Enter Your Name",
              icon: Icons.person,
            ),
            const Gap(30),
            const CustomTextField(
              hint: "Enter Your Email",
              icon: Icons.email,
            ),
            const Gap(30),
            const CustomTextField(hint: "Enter Password", icon: Icons.password),
            const Gap(30),
            const CustomTextField(
                hint: "Confirm Password", icon: Icons.password),
            const Gap(50),
            CustomButton(
                color: Colors.black,
                text: "SingUp",
                style: GoogleFonts.abyssinicaSil(
                    fontSize: 22,
                    color: const Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {}),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Dont have an account",
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
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ));
  }
}
