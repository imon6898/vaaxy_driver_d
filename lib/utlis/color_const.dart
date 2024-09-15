import 'package:flutter/material.dart';

class ColorConst {
  static Color BLUE_COLOR = colorFromHex('#164194');
  static Color PENDING_COLOR = colorFromHex('#FFB728');
  static Color APPROVE_COLOR = colorFromHex('#9FD89A');
  static Color REJECT_COLOR = colorFromHex('#E33849');
  static Color APP_LOGO_COLOR = colorFromHex('#FF275A');
  static Color GREY_BLACK_COLOR = colorFromHex('#4D4D4F');
  static Color GREY_WHITE_COLOR = colorFromHex('#EDEDED');
  static const Color WHITE_COLOR = Colors.white;
  static const Color BLACK_COLOR = Colors.black;
  static const Color LIGHT_BLACK_COLOR = Colors.black45;
  static const Color BLUE_GREY_COLOR = Colors.blueGrey;

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}
