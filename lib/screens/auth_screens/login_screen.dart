import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/login_controller.dart';
import 'package:vaaxy_driver/weidget/custom_container.dart';
import 'package:vaaxy_driver/weidget/custom_shining_button.dart';
import 'package:vaaxy_driver/weidget/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: CustomContainer(
              height: 320,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: controller.emailOrPhoneController,
                          hintText: 'Email or Phone',
                          filled: true,
                          disableOrEnable: true,
                        ),
                        Obx(() => CustomTextField(
                          controller: controller.passwordController,
                          hintText: 'Enter your password',
                          obscureText: !controller.isPasswordVisible.value,
                          filled: true,
                          disableOrEnable: true,
                          suffixWidget: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        )),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 58.0),
                          child: ShinyButton(
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              //controller.login(context);
                              controller.login(context);

                            },
                            color: Color(0xff95D4E5),
                            borderRadius: BorderRadius.circular(10),
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            //Get.to(() => ForgetSandOtpPage());
                          },
                          child: Text("Forget Password?", style: TextStyle(color: Colors.blue)),
                        ),
                        GestureDetector(
                          onTap: () {
                            //Get.to(() => LoginSandOtpPage());
                          },
                          child: Text("Create account?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
