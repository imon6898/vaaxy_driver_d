import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vaaxy_driver/screens/mail_otp_screens/controller/mail_otp_controller.dart';
import 'package:vaaxy_driver/weidget/custom_container.dart';
import 'package:vaaxy_driver/weidget/custom_shining_button.dart';
import 'package:vaaxy_driver/weidget/custom_text_field.dart';

class MailSentOtpScreen extends StatelessWidget {
  const MailSentOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MailOtpController>(builder: (controller) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final flipAnimation = Tween(begin: 1.0, end: 0.0).animate(animation);
                return AnimatedBuilder(
                  animation: flipAnimation,
                  child: child,
                  builder: (BuildContext context, Widget? child) {
                    final isFront = ValueKey(controller.isOtpSent.value) == child!.key;
                    final rotationY = isFront ? flipAnimation.value : 2 - flipAnimation.value;
                    final transform = Matrix4.rotationY(rotationY * pi);
                    return Transform(
                      transform: transform,
                      alignment: FractionalOffset.center,
                      child: child,
                    );
                  },
                );
              },
              child: controller.isOtpSent.value
                  ? Container(
                key: const ValueKey(true),
                child: CustomContainer(
                  height: 320,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Check Your Email",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 2),
                      ),
                      const Text(
                        "We've Sent The Code To Your Email",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Pinput(
                          length: 6,
                          isCursorAnimationEnabled: true,
                          pinAnimationType: PinAnimationType.rotation,
                          defaultPinTheme: PinTheme(
                            width: 40,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? Colors.black
                                  : Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          onChanged: (value) {
                            // Handle onChanged event if needed
                          },
                          onCompleted: (value) {
                            // Handle onCompleted event if needed
                          },
                          controller: controller.otpController,
                        ),
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ShinyButton(
                          width: MediaQuery.of(context).size.width,
                          onTap: () {
                            controller.verifyOtpMailControll();
                            //Get.offAndToNamed('/signupScreen');
                          },
                          color: const Color(0xff95D4E5),
                          borderRadius: BorderRadius.circular(10),
                          child: const Text(
                            "VERIFI OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : Container(
                key: const ValueKey(false),
                child: CustomContainer(
                  height: 320,
                  borderRadius: BorderRadius.circular(10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "sentOTPforsignup".tr,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 2),
                      ),
                      const Text(
                        "Enter Your Email to Get Your OTP",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        controller: controller.emailController,
                        hintText: 'Email',
                        filled: true,
                        disableOrEnable: true,
                        prefixIcon: const Icon(Icons.mail),
                      ),
                      const SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ShinyButton(
                          width: MediaQuery.of(context).size.width,
                          onTap: () {
                            controller.sendOtpEmailControll();
                          },
                          color: const Color(0xff95D4E5),
                          borderRadius: BorderRadius.circular(10),
                          child: const Text(
                            "SENT OTP",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
