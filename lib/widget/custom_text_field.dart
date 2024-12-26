import 'package:e_commerce_app/widget/app_color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  TextEditingController? controller;

  CustomFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.onSaved,
    bool? obscureText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: AppColor.kMainColor,
        ),
        filled: true,
        fillColor: AppColor.kSecondaryColor,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.color,
      this.style,
      required this.onPressed});
  final String text;
  final Color? color;
  final TextStyle? style;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          backgroundColor: color, // لون الخلفية
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // جعل الزر ذو أطراف دائرية
          ),
        ),
        child: Text(
          text,
          style: style,
        ));
  }
}

class WidgetBottom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const WidgetBottom({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.fontSize = 22,
    this.borderRadius = 20,
    this.padding = const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
