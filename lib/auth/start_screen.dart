import 'package:e_commerce_app/widget/app_color.dart';
import 'package:e_commerce_app/auth/login_screen.dart';
import 'package:e_commerce_app/auth/sing_up_screen.dart';
import 'package:e_commerce_app/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const Gap(60),
          Text(
            "Welcome to E-Commerce App",
            style: GoogleFonts.abyssinicaSil(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            // textAlign: TextAlign.center,
          ),
          const Gap(20),
          Text(
            "The best place to shop for all your needs. Start now!",
            style: GoogleFonts.abyssinicaSil(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(50),
          Image.asset(
            "assets/images/buy.png",
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.2,
            fit: BoxFit.cover,
          ),
          const Gap(30),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              text: "Login",
              style: GoogleFonts.abyssinicaSil(
                  fontSize: 22, color: const Color.fromARGB(255, 0, 0, 0)),
              color: AppColor.kMainColor),
          const Gap(30),
          CustomButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SingUpScreen(),
                  ),
                );
              },
              text: "SingUp",
              style: GoogleFonts.abyssinicaSil(
                  fontSize: 22,
                  color: const Color.fromARGB(255, 255, 255, 255)),
              color: const Color.fromARGB(255, 0, 0, 0))
          // const Spacer(),
        ],
      ),
    );
  }
}
