import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
  TextStyle? style;
  int? maxLine;
  String? text;

  CustomTextView({this.text, this.style, this.maxLine = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: style ?? const TextStyle(fontSize: 20),
      maxLines: maxLine,
    );
  }
}
