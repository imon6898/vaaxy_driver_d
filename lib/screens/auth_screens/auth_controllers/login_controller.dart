import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Define controllers for the text fields
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable for password visibility
  var isPasswordVisible = false.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Method to handle login (you can add your login logic here)
  void login(BuildContext context) {
    final emailOrPhone = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Add your login logic here
    // Example:
    // if (emailOrPhone == 'test@example.com' && password == 'password123') {
    //   Get.to(() => HomePage());
    // } else {
    //   Get.snackbar(
    //     'Error',
    //     'Invalid email or password',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
  }

  @override
  void onClose() {
    // Dispose the text controllers when the controller is closed
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
