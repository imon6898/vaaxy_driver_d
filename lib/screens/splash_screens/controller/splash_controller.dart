import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class SplashScreenController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward();

    // Navigate to the login screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Get.offAndToNamed('/authSelectScreen');
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
