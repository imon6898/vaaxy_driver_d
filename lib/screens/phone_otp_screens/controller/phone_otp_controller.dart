import 'dart:developer';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vaaxy_driver/Repository/auth_repo.dart';


class PhoneOtpController extends GetxController {
  Rx<Country> selectedDialogCountry = CountryPickerUtils.getCountryByIsoCode('US').obs;
  var phoneNumberController = TextEditingController();
  var otpController = TextEditingController();
  var isOtpSent = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  RxString countryCode = '1'.obs; // Default to US country code

  final AuthRepo _authRepo = AuthRepo();

  void toggleOtpSent() {
    isOtpSent.value = !isOtpSent.value;
    update();
  }

  @override
  void onClose() {
    phoneNumberController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  void showSuccessSnackbar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.black,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  Future<void> sendOtpPhoneControll() async {
    if (phoneNumberController.text.isEmpty) {
      errorMessage.value = "Phone number cannot be empty";
      showErrorSnackbar(errorMessage.value);
      return;
    }

    // Retrieve the country code
    String countryCodeValue = countryCode.value;

    // Remove all non-digit characters from the phone number
    String phoneNumber = phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

    // Format the phone number
    String formattedPhoneNumber = '+$countryCodeValue$phoneNumber';

    log("Formatted phone number: $formattedPhoneNumber");

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _authRepo.sendOtpPhoneRepo({'phoneNumber': formattedPhoneNumber});

      if (response['status'] == true) {
        toggleOtpSent(); // Toggle the state when OTP is successfully sent
        showSuccessSnackbar("OTP sent successfully!");
      } else {
        errorMessage.value = response['message'] ?? "Failed to send OTP";
        showErrorSnackbar(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Request failed: $e";
      showErrorSnackbar(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> verifyOtpPhoneControll() async {
    if (otpController.text.isEmpty) {
      errorMessage.value = "OTP cannot be empty";
      return;
    }

    String countryCodeValue = countryCode.value;
    String phoneNumber = phoneNumberController.text.replaceAll(RegExp(r'\D'), '');
    String formattedPhoneNumber = '+$countryCodeValue$phoneNumber';

    log("Formatted phone number: $formattedPhoneNumber");
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _authRepo.verifyOtpPhoneRepo({
        'phoneNumber': formattedPhoneNumber,
        'otp': otpController.text,
      });

      log("API Response: $response");

      if (response != null && response['status'] == true) {
        log("OTP verification successful, navigating to /mailSentOtpScreen");
        showSuccessSnackbar("OTP verified successfully!");

        Get.offAndToNamed('/mailSentOtpScreen', arguments: {'formattedPhoneNumber': formattedPhoneNumber});

        //Get.offAndToNamed('/mailSentOtpScreen');
      } else {
        errorMessage.value = response?['message'] ?? "Invalid OTP";
        showErrorSnackbar(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Request failed: $e";
      showErrorSnackbar(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }


}
