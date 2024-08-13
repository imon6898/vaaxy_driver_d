import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/Repository/auth_repo.dart';
import 'dart:developer';


class MailOtpController extends GetxController {
  var emailController = TextEditingController();
  var otpController = TextEditingController();
  var isOtpSent = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  String? passedPhoneNumber;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the passed phone number
    passedPhoneNumber = Get.arguments['formattedPhoneNumber'] ?? '';
    log("Received Phone Number: $passedPhoneNumber");
  }

  final AuthRepo _authRepo = AuthRepo();

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void toggleOtpSent() {
    isOtpSent.value = !isOtpSent.value;
    update();
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

  Future<void> sendOtpEmailControll() async {
    if (emailController.text.isEmpty) {
      errorMessage.value = "Email cannot be empty";
      showErrorSnackbar(errorMessage.value);
      return;
    }

    log("emailController == ${emailController.text}");

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final response = await _authRepo.sendOtpMailRepo({'email': emailController.text});

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

  Future<void> verifyOtpMailControll() async {
    if (otpController.text.isEmpty) {
      errorMessage.value = "OTP cannot be empty";
      //showErrorSnackbar("Error", errorMessage.value, Icons.error, Colors.red);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    log("otpController == ${otpController.text}");

    try {
      final response = await _authRepo.verifyOtpMailRepo({
        'email': emailController.text,
        'otp': otpController.text,
      });

      log("otpController print ${otpController.text}");

      if (response['status'] == true) {
        // Handle successful OTP verification
        showSuccessSnackbar("OTP verified successfully!");
        Get.offAndToNamed('/signupScreen', arguments: {'passedPhoneNumber': passedPhoneNumber, 'emailController': emailController.text});
        log("responseasdf ${response}");
      } else {
        errorMessage.value = response['message'] ?? "Invalid OTP";
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
