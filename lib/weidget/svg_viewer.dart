import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgViewer({required String svgFile, double width=500, double height=500, Color? color}){
  return SvgPicture.asset(
    svgFile,
    width: width,
    height: height,
    color: color,

  );
}