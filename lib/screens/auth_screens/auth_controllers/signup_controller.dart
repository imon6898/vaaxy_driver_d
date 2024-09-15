import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaaxy_driver/routes/app_routes.dart';

import '../../../Repository/signup_repo.dart';

class SignupController extends GetxController {
  var formNextKey = GlobalKey<FormState>();
  GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  RxString countryCode = '1'.obs;

  var imageFile;
  File? selectedDrivingLicenseImageFrontSide;
  File? selectedDrivingLicenseImageBackSide;
  File? selectedVehicleLicenseImageFrontSide;
  File? selectedVehicleLicenseImageBackSide;
  File? selectedInsuranceImageFrontSide;
  File? selectedInsuranceImageBackSide;
  var selectedGender;
  DateTime? selectedDate;
  var isPasswordVisible = false;
  var isConfirmPasswordVisible = false;
  var isflipCustomContainer = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void toggleOtpSent() {
    isflipCustomContainer.value = !isflipCustomContainer.value;
    update();
  }

  var signupNameController = TextEditingController();
  var signupMidNameController = TextEditingController();
  var signupLastNameController = TextEditingController();
  var signupDateController = TextEditingController();
  var ssnNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var streetAddressController = TextEditingController();
  var countrySearchController = TextEditingController();
  var cityController = TextEditingController();
  var zipCodeController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();

  var licenseNumberController = TextEditingController();
  var expiredateController = TextEditingController();
  var licenseTypeController = TextEditingController();
  var issuingStateController = TextEditingController();
  var vehicleBrandController = TextEditingController();
  var vehicleModelController = TextEditingController();
  var vehicleColorController = TextEditingController();
  var vehicleYearController = TextEditingController();
  var seatingCapacityController = TextEditingController();
  var vehicleNumberController = TextEditingController();
  var insuranceCompanyNameController = TextEditingController();
  var insurancePolicyNumberController = TextEditingController();
  var insurancePhoneNumberController = TextEditingController();

  String? passedPhoneNumber;
  String? emailController;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the passed phone number
    passedPhoneNumber = Get.arguments['passedPhoneNumber'] ?? '';
    log("Received Phone Number: $passedPhoneNumber");
    emailController = Get.arguments['emailController'] ?? '';
    log("Received Phone Number: $emailController");
  }


  final List<String> genderOptions = ['Male', 'Female','He/She', 'They/Them', 'Other'];
  List<File> vehicleSelectedFiles = [];

  String formatSSN(String ssn) {
    if (ssn.length > 3 && !ssn.contains('-')) {
      ssn = ssn.substring(0, 3) + '-' + ssn.substring(3);
    }
    if (ssn.length > 6 && !ssn.contains('-', 4)) {
      ssn = ssn.substring(0, 6) + '-' + ssn.substring(6);
    }
    return ssn;
  }


  void onFilesSelected(List<File> files, BuildContext context) {
    vehicleSelectedFiles = files;
    if (files.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add at least 4 images.'),
        ),
      );
    }
  }

  void setImageFile(File? file) {
    imageFile = file;
    update();
  }

  void setSelectedGender(String gender) {
    selectedGender = gender;
    update();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final BuildContext dialogContext = context;
    final DateTime? picked = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          child: Container(
            height: 300.0,
            color: Get.isDarkMode ? Colors.black : Colors.white, // Set container color based on dark mode
            child: Column(
              children: [
                Container(
                  height: 200.0,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      selectedDate = newDate;
                      signupDateController.text =
                          DateFormat('dd-MMM-yyyy').format(newDate);
                      update(); // Refresh the UI
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('Done'),
                        onPressed: () {
                          Navigator.of(dialogContext).pop(selectedDate);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      signupDateController.text = DateFormat('dd-MMM-yyyy').format(picked);
      update(); // Refresh the UI
    }
  }

  void selectCountry(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: CountryPickerCupertino(
                  initialCountry: CountryPickerUtils.getCountryByIsoCode('US'), // Initial country set to United States
                  onValuePicked: (Country country) {
                    countryController.text = country.name;
                    update(); // Refresh the UI
                  },
                ),
              ),
              Row(
                children: [
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  void selectIssueCountry(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.black : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: CountryPickerCupertino(
                  initialCountry: CountryPickerUtils.getCountryByIsoCode('US'), // Initial country set to United States
                  onValuePicked: (Country country) {
                    issuingStateController.text = country.name;
                    update(); // Refresh the UI
                  },
                ),
              ),
              Row(
                children: [
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }



  Future<void> registerDriver() async {
    isLoading.value = true;
    errorMessage.value = '';

    String phoneCode = '';
    String phoneNumber = '';
    if (passedPhoneNumber != null && passedPhoneNumber!.isNotEmpty) {
      final RegExp regex = RegExp(r'^(\+\d+)(\d+)$');
      final match = regex.firstMatch(passedPhoneNumber!);
      if (match != null) {
        phoneCode = match.group(1) ?? '';
        phoneNumber = match.group(2) ?? '';
      }
    }

    String insurancePhoneNumber = insurancePhoneNumberController.text.replaceAll(RegExp(r'\D'), '');
    String formattedInsurancePhoneNumber = '+$countryCode$insurancePhoneNumber';

    var params = {
      'FirstName': signupNameController.text,
      'MiddleName': signupMidNameController.text,
      'LastName': signupLastNameController.text,
      'Email': emailController,
      'DateOfBirth': signupDateController.text,
      'Gender': selectedGender,
      'Password': confirmPasswordController.text,
      'SSN': ssnNumberController.text,
      'Country': countryController.text,
      'PhoneNumber': "1322600847",
      'PhoneCode': "880",
      'InsurancePhoneNum': formattedInsurancePhoneNumber,
      'InsuranceNumber': insurancePolicyNumberController.text,
      'InsuranceCompany': insuranceCompanyNameController.text,
      'VehicleType': 'car',
      'NumberPlate': vehicleNumberController.text,
      'Capacity': seatingCapacityController.text,
      'LaunchhYear': vehicleYearController.text,
      'Color': vehicleColorController.text,
      'Modal': vehicleModelController.text,
      'Brand': vehicleBrandController.text,
      'IssuingState': issuingStateController.text,
      'LicenseType': licenseTypeController.text,
      'LicenseNumber': licenseNumberController.text,
      'ExpirationDate': expiredateController.text,
      'StreetAddress': streetAddressController.text,
      'City': cityController.text,
      'State': stateController.text,
      'ZipCode': zipCodeController.text,
      'SignUpAs': "Driver",
    };

    var requestFiles = <String, File>{};

// Add files to the map
    if (imageFile != null) {
      requestFiles['Picture'] = imageFile!;
      print('Picture file path: ${imageFile!.path}');
    }
    if (selectedInsuranceImageFrontSide != null) {
      requestFiles['InsuranceCopy'] = selectedInsuranceImageFrontSide!;
      print('InsuranceCopy file path: ${selectedInsuranceImageFrontSide!.path}');
    }
    if (selectedVehicleLicenseImageFrontSide != null) {
      requestFiles['VehicleCopy'] = selectedVehicleLicenseImageFrontSide!;
      print('VehicleCopy file path: ${selectedVehicleLicenseImageFrontSide!.path}');
    }
    if (selectedDrivingLicenseImageFrontSide != null) {
      requestFiles['LicenseCopyFront'] = selectedDrivingLicenseImageFrontSide!;
      print('LicenseCopyFront file path: ${selectedDrivingLicenseImageFrontSide!.path}');
    }
    if (selectedDrivingLicenseImageBackSide != null) {
      requestFiles['LicenseCopyBack'] = selectedDrivingLicenseImageBackSide!;
      print('LicenseCopyBack file path: ${selectedDrivingLicenseImageBackSide!.path}');
    }


    try {
      final bool response = await SignupRepo().signUpRepo(params, requestFiles);
      if (response) {
        Get.snackbar('Success', 'Registration successful');
        Get.offAndToNamed(AppRoutes.LoginScreen);
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }


}