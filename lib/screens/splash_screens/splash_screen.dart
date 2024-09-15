import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vaaxy_driver/screens/splash_screens/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(builder: (controller) {
      return Scaffold(
        body: Center(
          child: ScaleTransition(
            scale: controller.scaleAnimation,
            child: Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey[100]!,
              child: Image.asset(
                'assets/image/app_deverse_logo.png',
                width: 400,
                height: 400,
              ),
            ),
          ),
        ),
      );
    });
  }
}
