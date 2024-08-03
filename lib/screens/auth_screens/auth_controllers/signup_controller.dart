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

class SignupController extends GetxController {
  var formNextKey = GlobalKey<FormState>();
  GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();

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



  void registration(
      File? imageFile,
      String firstName,
      String midName,
      String lastName,
      String dob,
      String gender,
      String password,
      String confirmPassword,
      String streetAddress,
      String city,
      String zipCode,
      String state,
      String country,
      ) {
    if (formNextKey.currentState!.validate()) {
      toggleOtpSent();
    }
  }
}