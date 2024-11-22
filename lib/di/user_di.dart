import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaaxy_driver/model/OfferResponseModel.dart';
import 'package:vaaxy_driver/model/get_my_profile_model.dart';
import '../../../utlis/pref/pref.dart';

class UserDi extends GetxController {
  String fcmToken = "";
  String authToken = "";
  String userName = "";
  String userPhone = "";
  String userProfilePicture = ""; // Added for profile picture

  GetMyProfileModel myProfileModel = GetMyProfileModel();
  OfferResponseModel offerResponseModel = OfferResponseModel();

  @override
  Future<void> onInit() async {
    super.onInit();
    // fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    log("fcm token of the device = $fcmToken");

    SharedPreferences prefsTwo = await SharedPreferences.getInstance();
    String? userToken = prefsTwo.getString('auth_token',);
    log("userToken ==$userToken");
    // Retrieve auth token and other user data from local storage
    authToken = prefsTwo.getString('auth_token',) ?? '';
    // authToken = Pref.getValue(Pref.authToken);
    userName = prefsTwo.getString('firstName',)!;
    userPhone = prefsTwo.getString('email',)!;
    userProfilePicture = prefsTwo.getString('picture',)!;

    userName = Pref.getValue(Pref.userName);
    userPhone = Pref.getValue(Pref.userPhoneNumber);
    userProfilePicture = Pref.getValue(Pref.userProfilePicture);
  }

  void callFCMToken() async{
    // fcmToken = await FirebaseMessaging.instance.getToken()??'09jhgv';
    log("fcm token of the device = $fcmToken");
  }
}
