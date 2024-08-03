import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/select_auth_screens/auth_controller.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/select_auth_screens/shimmer_arrow/custom_swipe_button.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/select_auth_screens/shimmer_arrow/shimmer_arrow.dart';
import 'package:vaaxy_driver/weidget/custom_container.dart';

class AuthSelectScreen extends StatelessWidget {
  const AuthSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthSelectController>(builder: (controller)
    {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, bottom: 10, left: 10.0, right: 10),
            child: CustomContainer(
              height: MediaQuery.of(context).size.height,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    CustomSwipButtons(),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 0),
                          ShimmerArrowUp(),
                          SizedBox(height: 150),
                          ShimmerArrowDown(),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}



class CustomSwipButtons extends StatefulWidget {
  @override
  State<CustomSwipButtons> createState() => _CustomSwipButtonsState();
}

class _CustomSwipButtonsState extends State<CustomSwipButtons> {
  double _buttonPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        setState(() {
          _buttonPosition += details.delta.dy;
        });
      },
      onVerticalDragEnd: (details) {
        double screenHeight = MediaQuery.of(context).size.height;
        if (_buttonPosition < -screenHeight * 0.2) {
          Get.toNamed('/loginScreen');
          //Get.to(() => LoginScreen());
        } else if (_buttonPosition > screenHeight * 0.2) {
          Get.toNamed('/phoneSentOtpScreen');
          //Get.to(() => LoginPageRider());
        }
        setState(() {
          _buttonPosition = 0.0;
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 160,
              left: MediaQuery.of(context).size.width / 2 - 130,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 30),
                curve: Curves.easeInOut,
                transform: Matrix4.translationValues(0, _buttonPosition, 0),
                child: CustomSwipButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
