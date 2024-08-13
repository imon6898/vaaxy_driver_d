import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/data/impl/userInformation.dart';
import 'package:vaaxy_driver/data/network/userApiService.dart';
import 'package:vaaxy_driver/model/UsersModel.dart';

class UsersRepo{
  AuthApiService authApiService = UserInformation();

  Future<dynamic>? sendOTPRepo(Map<String,dynamic> params) async {
    dynamic responseData = await authApiService.sendOTPToNumber(ApiConstant.endPointSendOTP, params);
    log("message 2 = ");

    return responseData = responseData.data;
  }

  Future<dynamic>? submitOTPRepo(Map<String,dynamic> params) async {
    dynamic responseData = await authApiService.submitOTPWithNumber(ApiConstant.endPointSubmitOTP, params);

    return responseData = responseData.data;
  }

  Future<dynamic>? createNewAccountRepo(Map<String,dynamic> params) async {
    dynamic responseData = await authApiService.registerNewAccount(ApiConstant.endPointRegister, params);

    return responseData = responseData.data;
  }

  Future<dynamic>? logOutAccountRepo() async {
    dynamic responseData = await authApiService.logOutAccount(ApiConstant.endPointLogOut);
    return responseData.data; 
  }

}