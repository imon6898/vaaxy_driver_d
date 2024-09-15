import 'package:flutter/material.dart';

class CustomArrow extends StatelessWidget {
  final double angle;
  final Color color;
  final double size;

  CustomArrow({required this.angle, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * 3.14159 / 180, // Convert angle to radians
      child: Icon(Icons.arrow_back_ios_new_rounded, size: size, color: color),
    );
  }
}


class RotatedText extends StatelessWidget {
  final double angle;
  final Color color;
  final double fontSize;
  final String text;

  RotatedText({
    required this.angle,
    required this.color,
    required this.fontSize,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * 3.14159 / 180, // Convert angle to radians
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}