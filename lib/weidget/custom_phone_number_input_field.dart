import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';

class CustomPhoneNumberInput extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool enabled;
  final String hintText;
  final bool filled;
  final String? Function(String? value)? validator;
  final RxString countryCode; // Added countryCode as a parameter

  const CustomPhoneNumberInput({
    Key? key,
    required this.controller,
    this.onChanged,
    this.enabled = true,
    this.hintText = 'Enter your phone number',
    this.filled = true,
    this.validator,
    required this.countryCode, // Required countryCode
  }) : super(key: key);

  @override
  _CustomPhoneNumberInputState createState() => _CustomPhoneNumberInputState();
}

class _CustomPhoneNumberInputState extends State<CustomPhoneNumberInput> {
  late Rx<Country> selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('US').obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: widget.controller,
        enabled: widget.enabled,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          filled: widget.filled,
          fillColor: Get.isDarkMode ? Colors.black : Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.blueAccent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.blueAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.yellow, fontSize: 16),
          labelStyle: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
          labelText: 'Phone Number',
          hintText: widget.hintText,
          prefixIcon: InkWell(
            onTap: () => _openCountryPickerDialog(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 15),
                Obx(() {
                  return _buildDialogItem(selectedDialogCountry.value);
                }),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        keyboardType: TextInputType.phone,
        onChanged: widget.onChanged,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10), // Limit to 10 characters (phone number length)
          _PhoneNumberFormatter(), // Custom formatter
        ],
      ),
    );
  }

  void _openCountryPickerDialog() => Get.dialog(
    CountryPickerDialog(
      titlePadding: const EdgeInsets.all(8.0),
      searchCursorColor: Colors.pinkAccent,
      searchInputDecoration: const InputDecoration(hintText: 'Search...'),
      isSearchable: true,
      title: const Text('Select your phone code'),
      onValuePicked: (Country country) {
        selectedDialogCountry(country);
        widget.countryCode.value = country.phoneCode; // Update the countryCode
        // Optionally, update controller for displaying selected country code
      },
      itemBuilder: _buildDialogItem,
      priorityList: [
        CountryPickerUtils.getCountryByIsoCode('BD'),
        CountryPickerUtils.getCountryByIsoCode('US'),
      ],
    ),
  );

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      const SizedBox(width: 8.0),
      const Icon(Icons.arrow_drop_down_rounded),
      const SizedBox(width: 10),
      Text("+${country.phoneCode}"),
    ],
  );
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    var newText = '';
    if (text.length >= 1) {
      newText = '(${text.substring(0, min(text.length, 3))}';
    }
    if (text.length >= 4) {
      newText += ') ${text.substring(3, min(text.length, 6))}';
    }
    if (text.length >= 7) {
      newText += '-${text.substring(6, min(text.length, 10))}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
