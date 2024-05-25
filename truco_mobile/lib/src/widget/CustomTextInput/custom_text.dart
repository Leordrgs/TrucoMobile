import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double hintTextFontSize;
  final String labelText;
  final double labelTextFontSize;
  final bool obscureText;
  final double fontSize;

  CustomTextField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.labelTextFontSize = 12,
    this.hintTextFontSize = 12,
    this.obscureText = false,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: fontSize),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black, fontSize: hintTextFontSize),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black, fontSize: labelTextFontSize),
      ),
    );
  }
}
