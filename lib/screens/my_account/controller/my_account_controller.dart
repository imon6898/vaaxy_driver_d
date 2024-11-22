import 'package:get/get.dart';
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
  Rx<String?> picture = Rx<String?>(null);
  Rx<String?> dateOfBirth = Rx<String?>(null);
  Rx<String?> country = Rx<String?>(null);
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

  void getProfileData() async {
    isProfileLoading.value = true;

    try {
      var result = await HttpRequests.get(
          '${BaseUrl.baseUrl}/api/v1/GetDetailsDriver/${CacheManager.id}');

      // Parse the result if it's a valid response
      if (result != null && result.isNotEmpty) {
        final profile = result[0]; // Access the first object in the array

        // Assign values with null safety
        userId.value = profile['userId'] ?? '';
        driverId.value = profile['driverId'] ?? '';
        firstName.value = profile['firstName'] ?? '';
        middleName.value = profile['middleName'] ?? '';
        lastName.value = profile['lastName'] ?? '';
        email.value = profile['email'] ?? '';
        gender.value = profile['gender'] ?? '';
        picture.value = profile['picture'] ?? '';
        dateOfBirth.value = profile['dateOfBirth'] ?? '';
        country.value = profile['country'] ?? '';
        phoneNumber.value = profile['phoneNumber'] ?? '';
        insurancePhoneNum.value = profile['insurancePhoneNum'] ?? '';
        insuranceNumber.value = profile['insuranceNumber'] ?? '';
        insuranceCompany.value = profile['insuranceCompany'] ?? '';
        insuranceCopy.value = profile['insuranceCopy'] ?? '';
        vehicleType.value = profile['vehicleType'] ?? '';
        vehicleCopy.value = profile['vehicleCopy'] ?? '';
        numberPlate.value = profile['numberPlate'] ?? '';
        capacity.value = profile['capacity'] ?? '';
        launchYear.value = profile['launchYear'] ?? '';
        color.value = profile['color'] ?? '';
        modal.value = profile['modal'] ?? '';
        brand.value = profile['brand'] ?? '';
        issuingState.value = profile['issuingState'] ?? '';
        licenseType.value = profile['licenseType'] ?? '';
        licenseNumber.value = profile['licenseNumber'] ?? '';
        expirationDate.value = profile['expirationDate'] ?? '';
        licenseCopyFront.value = profile['licenseCopyFront'] ?? '';
        licenseCopyBack.value = profile['licenseCopyBack'] ?? '';
        streetAddress.value = profile['streetAddress'] ?? '';
        city.value = profile['city'] ?? '';
        state.value = profile['state'] ?? '';
        zipCode.value = profile['zipCode'] ?? '';
      }

      print('Profile details successfully loaded.');
    } catch (e) {
      print('Error fetching profile data: $e');
    } finally {
      isProfileLoading.value = false;
    }
  }

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }
}
