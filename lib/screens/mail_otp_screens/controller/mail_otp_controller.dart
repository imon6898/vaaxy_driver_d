import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class MailOtpController extends GetxController {
  var emailController = TextEditingController();
  var otpController = TextEditingController();
  var isOtpSent = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

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
      //backgroundColor: Colors.green,
      colorText: Colors.black,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  Future<void> sendOtpEmail() async {
    if (emailController.text.isEmpty) {
      errorMessage.value = "Email cannot be empty";
      showErrorSnackbar(errorMessage.value);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final url = Uri.parse('http://74.208.201.247:443/api/v1/send-otp-email');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': emailController.text});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == true) {
          toggleOtpSent(); // Toggle the state when OTP is successfully sent
          showSuccessSnackbar("OTP sent successfully!");
        } else {
          errorMessage.value = responseBody['message'] ?? "Failed to send OTP";
          showErrorSnackbar(errorMessage.value);
        }
      } else {
        errorMessage.value = "Server error: ${response.statusCode}";
        showErrorSnackbar(errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Request failed: $e";
      showErrorSnackbar(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.isEmpty) {
      errorMessage.value = "OTP cannot be empty";
      showErrorSnackbar(errorMessage.value);
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final url = Uri.parse('http://74.208.201.247:443/api/v1/verify-otp-email');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': emailController.text,
      'otp': otpController.text,
    });

    log("otpController print ${otpController.text}");

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['status'] == true) {
          // Handle successful OTP verification
          showSuccessSnackbar("OTP verified successfully!");
          Get.offAndToNamed('/signupScreen');
        } else {
          errorMessage.value = "Invalid OTP";
          showErrorSnackbar(errorMessage.value);
        }
      } else {
        errorMessage.value = "Server error: ${response.statusCode}";
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
