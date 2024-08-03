import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:vaaxy_driver/screens/phone_otp_screens/controller/phone_otp_controller.dart';
import 'package:vaaxy_driver/weidget/custom_container.dart';
import 'package:vaaxy_driver/weidget/custom_phone_number_input_field.dart';
import 'package:vaaxy_driver/weidget/custom_shining_button.dart';
import 'package:pinput/pinput.dart';

class PhoneSentOtpScreen extends StatelessWidget {
  const PhoneSentOtpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneOtpController>(builder: (controller) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
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
                  key: ValueKey(true),
                  child: CustomContainer(

                    height: 320,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Check Your Phone".tr,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 2),
                        ),
                        Text(
                          "We've Sent The Code To Your Phone".tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20),
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
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            onChanged: (value) {
                              // Handle onChanged event if needed
                            },
                            onCompleted: (value) {
                              // Handle onCompleted event if needed
                            },
                          ),
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10),
                          child: ShinyButton(
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              // Handle verify action
                              Get.offAndToNamed('/mailSentOtpScreen');
                            },
                            color: Color(0xff95D4E5),
                            borderRadius: BorderRadius.circular(10),
                            child: Text(
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
                  key: ValueKey(false),
                  child: CustomContainer(
                    height: 320,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "sentOTPforsignup".tr,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              height: 2),
                        ),
                        Text(
                          "enteryourphonenumbertogetyourotp".tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 30),
                        CustomPhoneNumberInput(
                          controller: controller.phoneNumberController,
                          onChanged: (phoneNumber) {
                            // Handle phone number change
                          },
                          hintText: 'Enter your phone number',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone number is required';
                            }
                            if (value.length < 8 || value.length > 13) {
                              return 'Phone number must be between 8 and 13 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10),
                          child: ShinyButton(
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              controller.toggleOtpSent();
                            },
                            color: Color(0xff95D4E5),
                            borderRadius: BorderRadius.circular(10),
                            child: Text(
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
              )
          ),
        ),
      );
    });
  }
}
