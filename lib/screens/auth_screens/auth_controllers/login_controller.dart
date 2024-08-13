import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/Repository/auth_repo.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  // Controllers for text fields
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable for password visibility
  var isPasswordVisible = false.obs;

  // Instance of SigninRepo for handling API calls
  final AuthRepo _authRepo = AuthRepo();

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Method to handle login
  Future<void> login(BuildContext context) async {
    final emailOrPhone = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      //_showSnackbar('Error', 'Please fill in all fields');
      return;
    }

    Map<String, dynamic> params = {
      'userName': emailOrPhone,
      'password': password,
    };

    try {
      // Make the API call
      var response = await _authRepo.signInDriverRepo(params);

      // Extract the data from the response
      var data = response.data;

      // Check if the response contains the necessary data
      // Check if the response contains the necessary data
      if (data != null && data['token'] != null) {
        // Successful login
        Get.offAndToNamed(AppRoutes.HomeScreen);
        //_showSnackbar('Success', 'Login successful');
      } else {
        // Handle different error scenarios based on the response
        String errorMessage = 'Invalid email or password'; // Default message

        if (data['error'] != null) {
          errorMessage = data['error'];
        }

        //_showSnackbar('Error', errorMessage);
      }

    } catch (error) {
      // Log the error and show a generic error message
      //_showSnackbar('Error', 'Login failed. Please try again.');
      debugPrint('Login error: $error');
    }
  }

  // Helper method to show snackbars
  // void _showSnackbar(String title, String message) {
  //   Get.snackbar(
  //     title,
  //     message,
  //     snackPosition: SnackPosition.BOTTOM,
  //     backgroundColor: Colors.redAccent,
  //     colorText: Colors.white,
  //   );
  // }

  // Dispose controllers when the controller is closed
  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
