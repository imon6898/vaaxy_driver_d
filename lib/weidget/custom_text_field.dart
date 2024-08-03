import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:simple_animations/movie_tween/movie_tween.dart';
import 'package:simple_animations/simple_animations.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final Icon? prefixIcon;
  final Widget? suffixWidget; // Accepts either Icon or IconButton
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final bool obscureText; // New parameter to indicate if it's a password field
  final Color? borderColor; // New parameter for custom border color
  final bool filled; // New parameter to indicate if the field should be filled
  final bool disableOrEnable;
  final TextInputType? keyboardType; // New parameter to specify the keyboard type
  final String? Function(String? value)? validator; // Validator function
  final Function(String value)? onChange; // Validator function

  const CustomTextField({
    Key? key,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.prefixIcon,
    this.suffixWidget, // Changed from suffixIcon to suffixWidget
    this.controller,
    this.textStyle,
    this.obscureText = false, // Default to false
    this.borderColor, // Required parameter for custom border color
    this.filled = false,
    required this.disableOrEnable,
    this.keyboardType, // Specify the keyboard type
    this.validator, // Validator function, not required
    this.onChange
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nonNullBorderColor = borderColor ?? Colors.grey; // Use grey as default color if borderColor is null

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        enabled: disableOrEnable,
        controller: controller,
        obscureText: obscureText, // Obscure text if it's a password field
        onChanged: onChange,
        style: textStyle ??
            TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ), // Use white text color for dark mode and black for light mode
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          filled: filled,
          fillColor: Get.isDarkMode ? Colors.black : Colors.white, // Adjust fillColor based on theme
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            borderSide: BorderSide(width: 2, color: nonNullBorderColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            borderSide: BorderSide(width: 2, color: nonNullBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            borderSide: BorderSide(width: 2, color: Colors.blueAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            borderSide: BorderSide(width: 2, color: Colors.red), // Color for the error border
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            borderSide: BorderSide(width: 2, color: Colors.red), // Color for the error border
          ),
          errorStyle: TextStyle(color: Colors.yellow, fontSize: 16), // Style for the error text
          labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black,),
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Border radius
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixWidget, // Changed from suffixIcon to suffixWidget
        ),
        validator: validator, // Assign the custom validator function
        autovalidateMode: AutovalidateMode.onUserInteraction, // Show validation error on user interaction
        keyboardType: keyboardType, // Set the keyboard type
      ),
    );
  }
}







enum _CustomSwitchParams { paddingLeft, color, text, rotation }

class CustomAnimatedSwitch extends StatelessWidget {
  final bool toggle;

  CustomAnimatedSwitch({required this.toggle});

  @override
  Widget build(BuildContext context) {
    var customTween = MovieTween()
      ..scene(duration: const Duration(seconds: 1))
          .tween(_CustomSwitchParams.paddingLeft, Tween(begin: 0.0, end: 30.0))
      ..scene(duration: const Duration(seconds: 1))
          .tween(_CustomSwitchParams.color, ColorTween(begin: Colors.red, end: Colors.green))
      ..scene(duration: const Duration(milliseconds: 100))
          .tween(_CustomSwitchParams.text, ConstantTween('OFF'))
          .thenTween(_CustomSwitchParams.text, ConstantTween('ON'), duration: const Duration(milliseconds: 500))
      ..scene(duration: const Duration(seconds: 1))
          .tween(_CustomSwitchParams.rotation, Tween(begin: -2 * pi, end: 0.0));

    return CustomAnimationBuilder<Movie>(
      control: toggle ? Control.play : Control.playReverse,
      startPosition: toggle ? 1.0 : 0.0,
      key: const Key('0'),
      duration: customTween.duration * 1.2,
      tween: customTween,
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Container(
          decoration: _outerDecoration(color: value.get(_CustomSwitchParams.color)),
          width: 60.0,
          height: 30.0,
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: value.get(_CustomSwitchParams.paddingLeft),
                  ),
                  child: Transform.rotate(
                    angle: value.get(_CustomSwitchParams.rotation),
                    child: Container(
                      decoration: _innerDecoration(
                        color: value.get(_CustomSwitchParams.color),
                      ),

                      width: 20.0,
                      child: Center(
                        child: Text(
                          value.get(_CustomSwitchParams.text),
                          style: const TextStyle(
                              height: 1.0,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration _outerDecoration({required Color color}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4.0,
          spreadRadius: 1.0,
        )
      ],
    );
  }

  BoxDecoration _innerDecoration({required Color color}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4.0,
          spreadRadius: 1.0,
        )
      ],
    );
  }
}








class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String? value;
  final void Function(String?)? onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    required this.hintText,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: value!.isEmpty ? null : value,  // Don't set an initial value if it's empty
      hint: Text(hintText),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(value),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        onChanged?.call(newValue); // Call onChanged callback with the new value
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE8E8E8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE8E8E8)), // Use the provided border color
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE8E8E8)), // Use the provided border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xffE8E8E8)),
        ),
      ),
    );
  }
}
