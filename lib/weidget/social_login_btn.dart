import 'package:flutter/material.dart';
import 'package:vaaxy_driver/weidget/svg_viewer.dart';

Widget socialLoginBtn({required String iconPath, required Function(String value) onTap}) {
  return GestureDetector(
    onTap: () => onTap(""),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1.0, 1.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        child: Center(
          child: svgViewer(
            svgFile: iconPath,
            height: 30.0,
            width: 30.0,
          ),
        ),
      ),
    ),
  );
}