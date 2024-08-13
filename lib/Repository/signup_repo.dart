import 'dart:io';

import 'package:vaaxy_driver/data/impl/signup_imp.dart';
import '../core/domain/api_const.dart';
import '../data/network/signup_api_service.dart';

class SignupRepo {
  SignupApiService signupApiService = SignupImpl();

  Future<bool> signUpRepo(Map<String, dynamic> params, Map<String, File> files) async {
    final response = await signupApiService.signUpDriver(ApiConstant.signUpDriver, params, files);
    return response;
  }
}


