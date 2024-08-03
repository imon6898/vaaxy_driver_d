import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/model/OfferResponseModel.dart';
import 'package:vaaxy_driver/model/get_my_profile_model.dart';

class UserDi extends GetxController{

  String fcmToken = "";
  String authToken = "";
  String userName = "";
  String userPhone = "";

  GetMyProfileModel myProfileModel = GetMyProfileModel();


  OfferResponseModel offerResponseModel =  OfferResponseModel();


  @override
  Future<void> onInit() async {
    super.onInit();

    fcmToken = await FirebaseMessaging.instance.getToken()??'';
    log("fcm token of the device = $fcmToken");

    //get auth token from local database or shared preference

  }
}