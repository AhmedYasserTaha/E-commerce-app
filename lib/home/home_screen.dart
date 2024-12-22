import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff77cbd2),
        body: ListView(
          children: [
            // const Gap(120),
            Center(
              child: Text(
                "Login",
                style: GoogleFonts.abyssinicaSil(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              decoration: InputDecoration(),
            )
          ],
        ));
  }
}
