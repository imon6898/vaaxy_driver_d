

import '../../core/domain/api_service.dart';
import '../network/phone_api_service.dart';

class PhoneImpl extends PhoneApiService {

  @override
  Future sendOtpPhone(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

  @override
  Future<dynamic> verifyOtpPhone(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }
}