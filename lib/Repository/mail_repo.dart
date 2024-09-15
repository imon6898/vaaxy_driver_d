

import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/data/impl/app_impl.dart';
import 'package:vaaxy_driver/data/impl/mail_impl.dart';
import 'package:vaaxy_driver/data/network/app_api_service.dart';

import '../core/domain/api_service.dart';
import '../data/network/mail_api_service.dart';

class MailRepo {
  MailApiService mailApiService = MailImpl();

  Future<dynamic> sendOtpRepo(Map<String, dynamic> params) async {
    dynamic responseData = await mailApiService.sendOtpMail(ApiConstant.sendOtpMail, params);
    return responseData = responseData.data;
  }

  Future<Map<String, dynamic>> verifyOtpRepo(Map<String, dynamic> params) async {
    dynamic responseData = await mailApiService.verifyOtpMail(ApiConstant.verifyOtpMail, params);
    return responseData = responseData.data;
  }
}
