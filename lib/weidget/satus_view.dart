import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vaaxy_driver/utlis/color_const.dart';
import 'package:vaaxy_driver/weidget/custom_text_view_light_color_line.dart';

Widget statusView({required String statusText}) {
  return Container(
    decoration: BoxDecoration(
      color: statusText.toLowerCase() == "pending"
          ? ColorConst.PENDING_COLOR
          : statusText.toLowerCase() == "approve" || statusText.toLowerCase() == "completed"
              ? ColorConst.APPROVE_COLOR
              : ColorConst.REJECT_COLOR,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 2.0, bottom: 2.0),
      child: CustomTextViewLightColorLine(
        text: statusText,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: ColorConst.BLUE_COLOR,
        ),
      ),
    )),
  );
}
