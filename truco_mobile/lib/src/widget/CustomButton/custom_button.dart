import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double fontSize;
  final double padding;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.black,
    this.textColor = Colors.white,
    this.width = 50,
    this.height = 50,
    this.fontSize = 12,
    this.padding = 16.0, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: () => onPressed(),
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
        ),
      ),
    );
  }
}
