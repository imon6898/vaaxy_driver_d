import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PhoneOtpController extends GetxController {
  Rx<Country> selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('US').obs;
  var phoneNumberController = TextEditingController();
  var isOtpSent = false.obs;

  void toggleOtpSent() {
    isOtpSent.value = !isOtpSent.value;
    update();
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    super.onClose();
  }
}
