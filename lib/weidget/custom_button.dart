import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:vaaxy_driver/utlis/color_const.dart';
import 'package:vaaxy_driver/utlis/textStyle.dart';

Widget customButton({
  required String text,
  Function(String v)? onPressed,
  VoidCallback? onPress,
  required bool isActive,
  bool showRightIcon = false,
  TextStyle? textStyle, // New parameter for custom text style
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        if (isActive) {
          if (onPressed != null) {
            onPressed("");
          } else if (onPress != null) {
            onPress();
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? ColorConst.BLUE_COLOR : ColorConst.BLUE_COLOR.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: showRightIcon
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: textStyle ?? textTheme.bodyLarge!.copyWith(
              color: ColorConst.WHITE_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            Icons.arrow_forward,
            color: ColorConst.WHITE_COLOR,
          ),
        ],
      )
          : Text(
        text,
        style: textStyle ?? textTheme.bodyLarge!.copyWith(
          color: ColorConst.WHITE_COLOR,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}






Widget customRedButton({
  required String text,
  required Function(String v) onPressed,
  required bool isActive,
  bool showRightIcon = false,
  TextStyle? textStyle, // New parameter for custom text style
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => onPressed(""),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? ColorConst.WHITE_COLOR : ColorConst.WHITE_COLOR,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 1, color: Colors.red), // Border style
        ),
      ),
      child: showRightIcon
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: textStyle ?? textTheme.bodyLarge!.copyWith(
              color: ColorConst.BLACK_COLOR,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(
            Icons.arrow_forward,
            color: ColorConst.BLACK_COLOR,
          )
        ],
      )
          : Text(
        text,
        style: textStyle ?? textTheme.bodyLarge!.copyWith(
          color: ColorConst.BLACK_COLOR,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}



