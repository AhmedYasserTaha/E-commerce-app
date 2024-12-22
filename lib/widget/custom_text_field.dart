import 'package:e_commerce_app/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
          cursorColor: AppColor.kMainColor,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: AppColor.kSecondaryColor,
            filled: true,
            prefixIcon: Icon(
              icon,
              color: AppColor.kMainColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white),
            ),
          )),
    );
  }
}
