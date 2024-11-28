import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vaaxy_driver/core/utils/cache/cache_manager.dart';
import 'package:vaaxy_driver/services/api_service.dart';
import 'package:vaaxy_driver/services/network/http_requests.dart';

class MyAccountController extends GetxController {
  // Global variables to hold response data
  Rx<String?> userId = Rx<String?>(null);
  Rx<String?> driverId = Rx<String?>(null);
  Rx<String?> firstName = Rx<String?>(null);
  Rx<String?> middleName = Rx<String?>(null);
  Rx<String?> lastName = Rx<String?>(null);
  Rx<String?> email = Rx<String?>(null);
  Rx<String?> gender = Rx<String?>(null);
  Rx<Uint8List?> picture = Rx<Uint8List?>(null); // Store as Uint8List
  Rx<String?> dateOfBirth = Rx<String?>(null);
  Rx<String?> country = Rx<String?>(null);
  Rx<String?> phoneCode = Rx<String?>(null);
  Rx<String?> phoneNumber = Rx<String?>(null);
  Rx<String?> insurancePhoneNum = Rx<String?>(null);
  Rx<String?> insuranceNumber = Rx<String?>(null);
  Rx<String?> insuranceCompany = Rx<String?>(null);
  Rx<String?> insuranceCopy = Rx<String?>(null);
  Rx<String?> vehicleType = Rx<String?>(null);
  Rx<String?> vehicleCopy = Rx<String?>(null);
  Rx<String?> numberPlate = Rx<String?>(null);
  Rx<String?> capacity = Rx<String?>(null);
  Rx<String?> launchYear = Rx<String?>(null);
  Rx<String?> color = Rx<String?>(null);
  Rx<String?> modal = Rx<String?>(null);
  Rx<String?> brand = Rx<String?>(null);
  Rx<String?> issuingState = Rx<String?>(null);
  Rx<String?> licenseType = Rx<String?>(null);
  Rx<String?> licenseNumber = Rx<String?>(null);
  Rx<String?> expirationDate = Rx<String?>(null);
  Rx<String?> licenseCopyFront = Rx<String?>(null);
  Rx<String?> licenseCopyBack = Rx<String?>(null);
  Rx<String?> streetAddress = Rx<String?>(null);
  Rx<String?> city = Rx<String?>(null);
  Rx<String?> state = Rx<String?>(null);
  Rx<String?> zipCode = Rx<String?>(null);

  RxBool isProfileLoading = RxBool(false);

  Future<void> getProfileData() async {
    isProfileLoading.value = true;

    try {
      var result = await HttpRequests.get(
          '${BaseUrl.baseUrl}/api/v1/GetDetailsDriver/${CacheManager.id}');

      // Parse the result if it's a valid response
      if (result != null && result.isNotEmpty) {
        final profile = result[0]; // Access the first object in the array

        // Assign values with null safety
        userId.value = profile['userId'] ?? '';
        print('userId: ${userId.value}');

        driverId.value = profile['driverId'] ?? '';
        print('driverId: ${driverId.value}');

        firstName.value = profile['firstName'] ?? '';
        print('firstName: ${firstName.value}');

        middleName.value = profile['middleName'] ?? '';
        print('middleName: ${middleName.value}');

        lastName.value = profile['lastName'] ?? '';
        print('lastName: ${lastName.value}');

        email.value = profile['email'] ?? '';
        print('email: ${email.value}');

        gender.value = profile['gender'] ?? '';
        print('gender: ${gender.value}');

        //picture.value = base64Decode(profile['picture'] ?? '');
        //print('picture: ${picture.value}');

        dateOfBirth.value = profile['dateOfBirth'] ?? '';
        print('dateOfBirth: ${dateOfBirth.value}');

        country.value = profile['country'] ?? '';
        print('country: ${country.value}');

        phoneCode.value = profile['phoneCode'] ?? 'N/A';
        print('phoneCode: ${phoneCode.value}');

        phoneNumber.value = profile['phoneNumber'] ?? '';
        print('phoneNumber: ${phoneNumber.value}');

        insurancePhoneNum.value = profile['insurancePhoneNum'] ?? '';
        print('insurancePhoneNum: ${insurancePhoneNum.value}');

        insuranceNumber.value = profile['insuranceNumber'] ?? '';
        print('insuranceNumber: ${insuranceNumber.value}');

        insuranceCompany.value = profile['insuranceCompany'] ?? '';
        print('insuranceCompany: ${insuranceCompany.value}');

        insuranceCopy.value = profile['insuranceCopy'] ?? '';
        print('insuranceCopy: ${insuranceCopy.value}');

        vehicleType.value = profile['vehicleType'] ?? '';
        print('vehicleType: ${vehicleType.value}');

        vehicleCopy.value = profile['vehicleCopy'] ?? '';
        print('vehicleCopy: ${vehicleCopy.value}');

        numberPlate.value = profile['numberPlate'] ?? '';
        print('numberPlate: ${numberPlate.value}');

        capacity.value = profile['capacity'] ?? '';
        print('capacity: ${capacity.value}');

        launchYear.value = profile['launchYear'] ?? 'N/A';
        print('launchYear: ${launchYear.value}');

        color.value = profile['color'] ?? '';
        print('color: ${color.value}');

        modal.value = profile['modal'] ?? '';
        print('modal: ${modal.value}');

        brand.value = profile['brand'] ?? '';
        print('brand: ${brand.value}');

        issuingState.value = profile['issuingState'] ?? '';
        print('issuingState: ${issuingState.value}');

        licenseType.value = profile['licenseType'] ?? '';
        print('licenseType: ${licenseType.value}');

        licenseNumber.value = profile['licenseNumber'] ?? '';
        print('licenseNumber: ${licenseNumber.value}');

        expirationDate.value = profile['expirationDate'] ?? '';
        print('expirationDate: ${expirationDate.value}');

        licenseCopyFront.value = profile['licenseCopyFront'] ?? '';
        print('licenseCopyFront: ${licenseCopyFront.value}');

        licenseCopyBack.value = profile['licenseCopyBack'] ?? '';
        print('licenseCopyBack: ${licenseCopyBack.value}');

        streetAddress.value = profile['streetAddress'] ?? '';
        print('streetAddress: ${streetAddress.value}');

        city.value = profile['city'] ?? '';
        print('city: ${city.value}');

        state.value = profile['state'] ?? '';
        print('state: ${state.value}');

        zipCode.value = profile['zipCode'] ?? '';
        print('zipCode: ${zipCode.value}');
      }

      print('Profile details successfully loaded.');
    } catch (e) {
      print('Error fetching profile data: $e');
    } finally {
      isProfileLoading.value = false;
    }
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';

    try {
      // Assuming the expirationDate is in "yyyyMM" format (e.g., "202512")
      final parsedDate = DateTime.parse(date.padRight(8, '01')); // Add day if missing
      return DateFormat('MMM dd, yy').format(parsedDate); // Format to "Month Day, Year"
    } catch (e) {
      return 'Invalid Date';
    }
  }


  @override
  void onInit() {
    String? base64Image = CacheManager.pictureBase64;

    // Decode the base64 string to a Uint8List if it is not null
    if (base64Image != null && base64Image.isNotEmpty) {
      picture.value = base64Decode(base64Image);  // Store the decoded image
    }

    getProfileData();
    super.onInit();
  }
}

