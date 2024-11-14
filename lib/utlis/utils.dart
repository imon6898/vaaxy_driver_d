import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void changeStatusBarColor(){
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.white
      )
  );
  const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light);
}

class MainUtils {
  static bool checkEmptyFields(List<TextEditingController> data) {
    for(TextEditingController element in  data) {
      if(element.text.isEmpty) {
        return true;
      }
    }
    return false;
  }

  static void showErrorSnackBar(String message, {Color? background}) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      message: message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: background ?? Colors.redAccent.shade700,
    ));
  }

  static void showTopErrorSnackBar(String message) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      message: message,
      backgroundColor: Colors.redAccent.shade200,
    ));
  }

  static void showSuccessSnackBar(String message, {Color? backgroundColor}) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      message: message,
      backgroundColor: backgroundColor ?? Colors.green.shade400,
    ));
  }
}