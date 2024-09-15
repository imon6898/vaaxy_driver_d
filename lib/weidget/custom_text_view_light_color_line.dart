import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vaaxy_driver/utlis/textStyle.dart';

class CustomTextViewLightColorLine extends StatelessWidget {
  TextStyle? style;
  int? maxLine;
  String text;
  TextAlign textAlign;

  CustomTextViewLightColorLine({this.text = '', this.style, this.maxLine = 1000, this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style??textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w100, fontSize: 14.sp, color: Colors.black38),
      maxLines: maxLine,
    );
  }
}
