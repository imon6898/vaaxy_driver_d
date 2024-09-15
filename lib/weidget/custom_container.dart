import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final Widget? child;
  final BorderRadius borderRadius;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  CustomContainer({
    this.height = 200,
    this.child,
    this.borderRadius = BorderRadius.zero,
    this.begin = Alignment.centerLeft, // Default begin point
    this.end = Alignment.centerRight, // Default end point
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: begin, // Use custom or default begin point
          end: end, // Use custom or default end point
          colors: [
            Color(0xff95D4E5),
            Colors.blueGrey.withOpacity(0.7),
          ],
          stops: [0.3, 0.7], // 10% and 70% of the width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.7),
            spreadRadius: -5,
            blurRadius: 12,
            offset: Offset(-5, 0), // Offset to the left
          ),
        ],
      ),
      child: child != null ? Center(child: child) : null,
    );
  }
}
