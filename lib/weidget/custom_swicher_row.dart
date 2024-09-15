import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text_field.dart';

class CustomSwitchRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final RxBool switchValue;
  final Function toggleFunction;

  const CustomSwitchRow({
    Key? key,
    required this.title,
    this.subtitle = '',
    required this.switchValue,
    required this.toggleFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyle(color: Color(0xffc7bbbb), fontSize: 10),
                ),
              GestureDetector(
                onTap: () => toggleFunction(),
                child: Obx(() => CustomAnimatedSwitch(toggle: switchValue.value)),
              ),
            ],
            ),
        );
    }
}