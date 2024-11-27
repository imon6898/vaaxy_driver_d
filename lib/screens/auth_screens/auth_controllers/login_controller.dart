import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaaxy_driver/Repository/auth_repo.dart';
import 'package:vaaxy_driver/core/utils/cache/cache_manager.dart';
import '../../../core/domain/api_service.dart';
import '../../../di/user_di.dart';
import '../../../routes/app_routes.dart';
import '../../../utlis/pref/pref.dart';

class LoginController extends GetxController {
  // Controllers for text fields
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable for password visibility
  var isPasswordVisible = false.obs;

  // Instance of AuthRepo for handling API calls
  final AuthRepo _authRepo = AuthRepo();

  UserDi userDi = Get.find<UserDi>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.put(UserDi());
    //otp

  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Method to handle login
  Future<void> login(BuildContext context) async {
    final emailOrPhone = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();

   // SharedPreferences prefs = await SharedPreferences.getInstance();
    if (emailOrPhone.isEmpty || password.isEmpty) {
      //_showSnackbar('Error', 'Please fill in all fields');
      return;
    }

    Map<String, dynamic> params = {
      'userName': emailOrPhone,
      'password': password,
      "signUpAs": "Driver"
    };

    log('check before post..: ${params}');

    try {
      // Make the API call
      var response = await _authRepo.signInDriverRepo(params);

      // Extract the data from the response
      var data = response.data;

      // Check if the response contains the necessary data
      // Check if the response contains the necessary data
      if (data != null && data['token'] != null) {

        await CacheManager.setId(data['id'] ?? "");
        await CacheManager.setToken(data['token'] ?? "");
        await CacheManager.setEmail(data['email'] ?? "");
        await CacheManager.setFirstName(data['firstName'] ?? "");
        await CacheManager.setSignUpAs(data['signUpAs'] ?? "");
        await CacheManager.setDriverId(data['driverId'] ?? "");
        // Successful login
        //await _saveLoginData(data);
        log('check user token..: ${ data}');
        log('check user token..: ${ data['token'] ?? ""}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString( "auth_token",data['token']);
        log('check user token-1..: ${ data['token'] ?? ""}');

        //Pref.setValue(Pref.authToken, data['token'] ?? "");
        await prefs.setString ("firstName",data['firstName'] ?? "");
        await prefs.setString ("email",data['email'] ?? "");
        await prefs.setString ("picture",data['picture'] ?? "");
        await prefs.setString ("pictureBase64",data['pictureBase64'] ?? "");


        SharedPreferences prefsTwo = await SharedPreferences.getInstance();
        String? userToken = prefsTwo.getString('auth_token',);
        log('check user token-2..: ${userToken}');


        userDi.authToken = data['token'] ?? "";
        userDi.userName = data['firstName'] ?? "";
        userDi.userPhone = data['email'] ?? "";
        userDi.userProfilePicture = data['picture'] ?? "";



        await CacheManager.setId(data['id'] ?? "");
        await CacheManager.setToken(data['token'] ?? "");
        await CacheManager.setEmail(data['email'] ?? "");
        await CacheManager.setFirstName(data['firstName'] ?? "");
        await CacheManager.setSignUpAs(data['signUpAs'] ?? "");
        await CacheManager.setDriverId(data['driverId'] ?? "");


        // CacheManager.setId((data['id'] is int) ? data['id'].toString() : "");
        // print("ID: ${data['id'] ?? ""} | Type: ${(data['id'] is int) ? 'int' : 'String'}");
        //
        // CacheManager.setToken(data['token'] ?? "");
        // print("Token: ${data['token'] ?? ""} | Type: ${data['token']?.runtimeType}");
        //
        // CacheManager.setEmail(data['email'] ?? "");
        // print("Email: ${data['email'] ?? ""} | Type: ${data['email']?.runtimeType}");
        //
        // CacheManager.setFirstName(data['firstName'] ?? "");
        // print("First Name: ${data['firstName'] ?? ""} | Type: ${data['firstName']?.runtimeType}");
        //
        // CacheManager.setSignUpAs(data['signUpAs'] ?? "");
        // print("Sign Up As: ${data['signUpAs'] ?? ""} | Type: ${data['signUpAs']?.runtimeType}");
        //
        // CacheManager.setDriverId((data['driverId'] is int) ? data['driverId'].toString() : "");
        print("Driver ID: ${data['driverId'] ?? ""} | Type: ${(data['driverId'] is int) ? 'int' : 'String'}");
        Pref.setValue(Pref.authToken, data['token'] ?? "");
        Pref.setValue(Pref.userName, data['firstName'] ?? "");
        Pref.setValue(Pref.userPhoneNumber, data['email'] ?? "");
        Pref.setValue(Pref.userProfilePicture, data['picture'] ?? "");

        Get.offAndToNamed(AppRoutes.HomeScreen);
        //_showSnackbar('Success', 'Login successful');
        showSuccessSnackbar(message: 'Login successful');
      } else {
        // Handle different error scenarios based on the response
        String errorMessage = 'Invalid email or password'; // Default message

        if (data['error'] != null) {
          errorMessage = data['error'];
        }

        showErrorSnackbar(message: 'Login failed. Please try again.');
      }

    } catch (error) {
      // Log the error and show a generic error message
      //_showSnackbar('Error', 'Login failed. Please try again.');
      debugPrint('Login error: $error');
      showErrorSnackbar(message: 'Login failed. Please try again.');
    }
  }


  // Helper method to save login data in local storage
  Future<void> _saveLoginData(Map<String, dynamic> data) async {
    final box = GetStorage();
    await box.write(Pref.authToken, data['token'] ?? "");
    await box.write(Pref.userName, data['firstName'] ?? "");
    await box.write(Pref.userPhoneNumber, data['email'] ?? "");
    await box.write(Pref.userProfilePicture, data['picture'] ?? ""); // Save picture URL if needed
  }

  // Dispose controllers when the controller is closed
  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

