import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/cache/cache_manager.dart';
import '../../../di/user_di.dart';
import '../../../routes/app_routes.dart';
import '../../../utlis/pref/pref.dart';

class SplashScreenController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  UserDi userDi = Get.find<UserDi>();

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    animationController.forward();

    // Retrieve the auth token from local storage
    userDi.authToken = Pref.getValue(Pref.authToken);

    // Navigate to the appropriate screen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (userDi.authToken.isNotEmpty) {
        log("Auth token from UserDi: ${userDi.authToken}");
        log("Auth token from Pref: ${Pref.getValue(Pref.authToken)}");
        CacheManager.initAuth((pref) {

        });
        Get.offAndToNamed('/homeScreen');
      } else {
        Get.offAndToNamed('/authSelectScreen');
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
