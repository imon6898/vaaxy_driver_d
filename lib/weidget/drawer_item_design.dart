import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vaaxy_driver/utlis/textStyle.dart';
import 'package:vaaxy_driver/weidget/svg_viewer.dart';

drawerItemDesign({required String iconPath, required String title, required Function(String v) callBack}) {
  return ListTile(
    title: Text(
      title,
      style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp),
    ),
    leading: svgViewer(svgFile: iconPath, width: 20, height: 20),
    iconColor: Colors.red,
    onTap: () => callBack(title), // change code by imam > onTap: () {},
  );
}
