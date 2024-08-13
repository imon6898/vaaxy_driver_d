import 'dart:io';

import 'package:vaaxy_driver/core/domain/api_service.dart';
import '../network/signup_api_service.dart';


class SignupImpl extends SignupApiService {
  @override
  Future<bool> signUpDriver(String url, Map<String, dynamic> params, [Map<String, File>? files]) async {
    var requestFiles = <String, File>{};
    if (files != null) {
      requestFiles.addAll(files);
    }

    bool response = await ApiService().multipleFileUpload(
        url,
        params,
        files: requestFiles
    );
    return response;
  }
}




