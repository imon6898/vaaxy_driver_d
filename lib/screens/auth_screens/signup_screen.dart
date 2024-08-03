import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/screens/auth_screens/auth_controllers/signup_controller.dart';
import 'package:vaaxy_driver/weidget/custom_container.dart';
import 'package:vaaxy_driver/weidget/custom_image_picker.dart';
import 'package:vaaxy_driver/weidget/custom_phone_number_input_field.dart';
import 'package:vaaxy_driver/weidget/custom_text_field.dart';
import 'package:vaaxy_driver/weidget/custom_shining_button.dart';
import 'package:vaaxy_driver/weidget/vehicle_image_selector.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0, bottom: 10, left: 10.0, right: 10),
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 2),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final flipAnimation = Tween(begin: 1.0, end: 0.0).animate(animation);
              return AnimatedBuilder(
                animation: flipAnimation,
                child: child,
                builder: (BuildContext context, Widget? child) {
                  final isFront = ValueKey(controller.isflipCustomContainer.value) == child!.key;
                  final rotationY = isFront ? flipAnimation.value : 1 - flipAnimation.value;
                  final transform = Matrix4.rotationY(rotationY * pi);
                  return Transform(
                    transform: transform,
                    alignment: FractionalOffset.center,
                    child: child,
                  );
                },
              );
            },
            child: controller.isflipCustomContainer.value
                ? Container(
              key: const ValueKey(true),
              child: CustomContainer(
            height: MediaQuery.of(context).size.height,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.registrationFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      const Text("Add Driving License Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 6,
                            child: CustomTextField(
                              controller: controller.licenseNumberController,
                              hintText: 'License Number',
                              filled: true,
                              disableOrEnable: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your license number';
                                }
                                if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                                  return 'License number can only contain letters and numbers';
                                }
                                if (value.length < 6 || value.length > 15) {
                                  return 'License number should be between 6 and 15 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            flex: 4,
                            child: CustomTextField(
                              controller: controller.expiredateController,
                              hintText: 'Expire date',
                              filled: true,
                              disableOrEnable: true,
                              keyboardType: TextInputType.number,
                              onChange: (value) {
                                if (value.length == 2 && !value.contains('/')) {
                                  value = '$value/';
                                  controller.expiredateController.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.fromPosition(TextPosition(offset: value.length)),
                                  );
                                }
                                if (value.length > 5) {
                                  value = value.substring(0, 5);
                                  controller.expiredateController.value = TextEditingValue(
                                    text: value,
                                    selection: TextSelection.fromPosition(TextPosition(offset: value.length)),
                                  );
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Expire date';
                                }
                                if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                                  return 'Use MM/YY format';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomTextField(
                              controller: controller.licenseTypeController,
                              hintText: 'License Type',
                              filled: true,
                              disableOrEnable: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the license type';
                                }
                                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                  return 'License type can only contain letters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                controller.selectIssueCountry(context);
                              },
                              child: CustomTextField(
                                controller: controller.issuingStateController,
                                hintText: 'Issuing State',
                                filled: true,
                                disableOrEnable: false,
                                keyboardType: TextInputType.number,
                                suffixWidget: const Icon(Icons.arrow_drop_down_rounded),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Zip Code';
                                  }
                                  if (!value.contains(RegExp(r'[0-9]'))) {
                                    return 'Use [0-9] zipcode';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      CustomImagePicker(
                        heading: 'Driving License Image (Front side)',
                        selectedImage: controller.selectedDrivingLicenseImageFrontSide, // Pass the selected image
                        onImagePicked: (File? image) {
                          controller.selectedDrivingLicenseImageFrontSide = image;
                          controller.update(); // Ensure UI updates with GetBuilder
                        },
                      ),
                      CustomImagePicker(
                        heading: 'Driving License Image (Back side)',
                        selectedImage: controller.selectedDrivingLicenseImageBackSide, // Pass the selected image
                        onImagePicked: (File? image) {
                          controller.selectedDrivingLicenseImageBackSide = image;
                          controller.update(); // Ensure UI updates with GetBuilder
                        },
                      ),


                      const SizedBox(height: 10),

                      const Text("Add Vehicle Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomTextField(
                              controller: controller.vehicleBrandController,
                              hintText: 'Vehicle Brand',
                              filled: true,
                              disableOrEnable: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the vehicle brand';
                                }
                                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                  return 'Use only letters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CustomTextField(
                              controller: controller.vehicleModelController,
                              hintText: 'Vehicle Model',
                              filled: true,
                              disableOrEnable: true,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the vehicle model';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomTextField(
                              controller: controller.vehicleColorController,
                              hintText: 'Vehicle Color',
                              filled: true,
                              disableOrEnable: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the vehicle color';
                                }
                                if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                  return 'Use only letters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CustomTextField(
                              controller: controller.vehicleYearController,
                              hintText: 'Vehicle Year',
                              filled: true,
                              disableOrEnable: true,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the vehicle year';
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Use only numbers';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CustomTextField(
                              controller: controller.seatingCapacityController,
                              hintText: 'Seating Capacity',
                              filled: true,
                              disableOrEnable: true,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the seating capacity';
                                }
                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Use only numbers';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: CustomTextField(
                              controller: controller.vehicleNumberController,
                              hintText: 'Vehicle Number',
                              filled: true,
                              disableOrEnable: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the vehicle number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),

                      CustomImagePicker(
                        heading: 'Vehicle License Image (Front side)',
                        selectedImage: controller.selectedVehicleLicenseImageFrontSide, // Pass the selected image
                        onImagePicked: (File? image) {
                          controller.selectedVehicleLicenseImageFrontSide = image;
                          controller.update(); // Ensure UI updates with GetBuilder
                        },
                      ),
                      CustomImagePicker(
                        heading: 'Vehicle License Image (Back side)',
                        selectedImage: controller.selectedVehicleLicenseImageBackSide, // Pass the selected image
                        onImagePicked: (File? image) {
                          controller.selectedVehicleLicenseImageBackSide = image;
                          controller.update(); // Ensure UI updates with GetBuilder
                        },
                      ),

                      const SizedBox(height: 10),

                      const Text("Vehicle Images", style: TextStyle( fontSize: 16, color: Colors.black),),

                      FileSelector(
                        onFilesSelected: (files) {
                          controller.onFilesSelected(files, context);
                        },
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Add Insurance Info",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
                      ),

                      CustomTextField(
                        controller: controller.insuranceCompanyNameController,
                        hintText: 'Insurance Company Name',
                        filled: true,
                        disableOrEnable: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the insurance company name';
                          }
                          return null;
                        },
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(top: 8.0),
                      //   child: TextField(
                      //     controller: controller.insurancePhoneNumberController,
                      //     decoration: InputDecoration(
                      //       contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      //       filled: true,
                      //       fillColor: Get.isDarkMode ? Colors.black : Colors.white,
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                      //       ),
                      //       disabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(width: 2, color: Colors.grey),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(width: 2, color: Colors.blueAccent),
                      //       ),
                      //       focusedErrorBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(width: 2, color: Colors.red),
                      //       ),
                      //       errorBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //         borderSide: BorderSide(width: 2, color: Colors.red),
                      //       ),
                      //       errorStyle: TextStyle(color: Colors.yellow, fontSize: 16),
                      //       labelStyle: TextStyle(
                      //           color: Get.isDarkMode ? Colors.white : Colors.black),
                      //       labelText: 'Phone Number',
                      //       hintText: 'Enter your phone number',
                      //       prefixIcon: InkWell(
                      //         onTap: () => controller.openCountryPickerDialog(),
                      //         child: Row(
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             const Gap(15),
                      //             Obx(() {
                      //               return controller.buildDialogItem(
                      //                   controller.selectedDialogCountry.value);
                      //             }),
                      //             const Gap(10),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     keyboardType: TextInputType.phone,
                      //     onChanged: (phoneNumber) {
                      //       // Handle phone number change
                      //     },
                      //     inputFormatters: [
                      //       FilteringTextInputFormatter.digitsOnly,
                      //       LengthLimitingTextInputFormatter(10), // Limit to 10 characters (phone number length)
                      //       _PhoneNumberFormatter(), // Custom formatter
                      //     ],
                      //   ),
                      // ),
                      CustomPhoneNumberInput(
                        controller: controller.insurancePhoneNumberController,
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


                      CustomTextField(
                        controller: controller.insurancePolicyNumberController,
                        hintText: 'Insurance Policy Number',
                        filled: true,
                        disableOrEnable: true,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter insurance policy number';
                          }
                          // You can add more specific validation rules here if needed
                          return null; // Return null if the input is valid
                        },
                      ),



                      CustomImagePicker(
                        heading: 'Insurance Image (Front side)',
                        selectedImage: controller.selectedInsuranceImageFrontSide, // Pass the selected image
                        onImagePicked: (File? image) {
                          controller.selectedInsuranceImageFrontSide = image;
                          controller.update(); // Ensure UI updates with GetBuilder
                        },
                      ),
                      CustomImagePicker(
                        heading: 'Insurance Image (Back side)',
                        selectedImage: controller.selectedInsuranceImageBackSide, // Pass the selected image
                        onImagePicked: (File? image) {
                          controller.selectedInsuranceImageBackSide = image;
                          controller.update(); // Ensure UI updates with GetBuilder
                        },
                      ),

                      const SizedBox(height: 60),
                      Row(
                        children: [
                          Flexible(
                            child: ShinyButton(
                              width: MediaQuery.of(context).size.width,
                              onTap: () {
                                controller.toggleOtpSent();
                              },
                              color: const Color(0xff95D4E5),
                              borderRadius: BorderRadius.circular(10),
                              child: const Text(
                                "Previous",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: ShinyButton(
                              width: MediaQuery.of(context).size.width,
                              onTap: () {
                                if (controller.registrationFormKey.currentState!.validate()) {
                                  // Proceed with registration or navigation to the next page
                                  // Example: controller.gotonextpage();
                                  // Replace 'gotonextpage' with your actual logic for navigation or submission
                                }
                              },
                              color: const Color(0xff95D4E5),
                              borderRadius: BorderRadius.circular(10),
                              child: const Text(
                                "Signup",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
            )
                : Container(
              key: const ValueKey(false),
              child: CustomContainer(
                height: MediaQuery.of(context).size.height,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formNextKey,
                      child: Column(
                        children: [
                          CustomImagePickers(
                            imageFile: controller.imageFile,
                            onImageSelected: (file) {
                              controller.setImageFile(file);
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: controller.signupNameController,
                            hintText: 'First Name',
                            filled: true,
                            disableOrEnable: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              if (!value.contains(RegExp(r'[a-z]')) || !value.contains(RegExp(r'[A-Z]'))) {
                                return 'Use [A-Z] and [a-z] letters';
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomTextField(
                                  controller: controller.signupMidNameController,
                                  hintText: 'Mid Name',
                                  filled: true,
                                  disableOrEnable: true,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: CustomTextField(
                                  controller: controller.signupLastNameController,
                                  hintText: 'Last Name',
                                  filled: true,
                                  disableOrEnable: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your last name';
                                    }
                                    if (!value.contains(RegExp(r'[a-z]')) || !value.contains(RegExp(r'[A-Z]'))) {
                                      return 'Use [A-Z] and [a-z] letters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.selectDate(context);
                            },
                            child: CustomTextField(
                              controller: controller.signupDateController,
                              hintText: 'Date of Birth',
                              filled: true,
                              disableOrEnable: false,
                              suffixWidget: IconButton(
                                onPressed: () {
                                  controller.selectDate(context);
                                },
                                icon: const Icon(Icons.date_range_sharp),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your birthday';
                                }
                                return null;
                              },
                            ),
                          ),

                          CustomTextField(
                            controller: controller.ssnNumberController,
                            hintText: 'SSN Number',
                            filled: true,
                            disableOrEnable: true,
                            keyboardType: TextInputType.number,
                            onChange: (text) {
                              // Format the SSN as it's being typed
                              String formattedSSN = controller.formatSSN(text);
                              controller.ssnNumberController.text = formattedSSN;
                              controller.ssnNumberController.selection = TextSelection.fromPosition(
                                TextPosition(offset: formattedSSN.length),
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter SSN number';
                              }
                              // You can add more specific validation rules here if needed
                              return null; // Return null if the input is valid
                            },
                          ),


                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width, // Set width to screen width
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                    width: 2, // Border width
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10), // Optional: to give rounded corners
                                ),
                                child: DropdownButton<String>(
                                  hint: Text('Select Gender'),
                                  value: controller.selectedGender,
                                  padding: EdgeInsets.only(left: 20),
                                  menuMaxHeight: 250,
                                  borderRadius: BorderRadius.circular(10),
                                  onChanged: (String? newValue) {
                                    controller.setSelectedGender(newValue!);
                                  },
                                  dropdownColor: Colors.white,
                                  items: controller.genderOptions.map((String gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(
                                        gender,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                      ),
                                    );
                                  }).toList(),

                                  isExpanded: true, // Make dropdown fill the container
                                  underline: SizedBox(height: 10,), // Remove the default underline
                                ),
                              ),
                              if (controller.selectedGender == null)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Please select a gender option',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          CustomTextField(
                            controller: controller.passwordController,
                            hintText: 'Enter password',
                            obscureText: !controller.isPasswordVisible,
                            filled: true,
                            disableOrEnable: true,
                            suffixWidget: IconButton(
                              icon: Icon(controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                controller.togglePasswordVisibility();
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (!value.contains(RegExp(r'[a-z]')) || !value.contains(RegExp(r'[A-Z]'))) {
                                return 'Password must use [a-z] & [A-Z] letters';
                              }
                              if (!value.contains(RegExp(r'[0-9]'))) {
                                return 'Password must use [0-9] number';
                              }
                              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                return 'Password must use [!@#%^&';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: controller.confirmPasswordController,
                            hintText: 'Confirm password',
                            obscureText: !controller.isConfirmPasswordVisible,
                            filled: true,
                            disableOrEnable: true,
                            suffixWidget: IconButton(
                              icon: Icon(controller.isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                              onPressed: () {
                                controller.toggleConfirmPasswordVisibility();
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter confirm password';
                              }
                              if (value != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: controller.streetAddressController,
                            hintText: 'Street Address',
                            filled: true,
                            disableOrEnable: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter street address';
                              }
                              return null;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomTextField(
                                  controller: controller.cityController,
                                  hintText: 'City',
                                  filled: true,
                                  disableOrEnable: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Zip Code';
                                    }
                                    if (!value.contains(RegExp(r'[a-z]')) || !value.contains(RegExp(r'[A-Z]'))) {
                                      return 'Use [A-Z] and [a-z] letters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: CustomTextField(
                                  controller: controller.zipCodeController,
                                  hintText: 'Zip Code',
                                  filled: true,
                                  disableOrEnable: true,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Zip Code';
                                    }
                                    if (!value.contains(RegExp(r'[0-9]'))) {
                                      return 'Use [0-9] zipcode';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            controller: controller.stateController,
                            hintText: 'State',
                            filled: true,
                            disableOrEnable: true,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.selectCountry(context);
                            },
                            child: CustomTextField(
                              controller: controller.countryController,
                              hintText: 'Country',
                              filled: true,
                              disableOrEnable: false,
                              suffixWidget: const Icon(Icons.arrow_drop_down_rounded),
                            ),
                          ),

                          const SizedBox(height: 60),
                          ShinyButton(
                            width: MediaQuery.of(context).size.width,
                            onTap: () {
                              //if (controller.formNextKey.currentState!.validate()) {
                                // Proceed with toggling OTP sent status
                                controller.toggleOtpSent();
                              //}
                            },
                            color: const Color(0xff95D4E5),
                            borderRadius: BorderRadius.circular(10),
                            child: const Text(
                              "NEXT",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
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




