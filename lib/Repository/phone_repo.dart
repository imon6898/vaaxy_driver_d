import '../core/domain/api_const.dart';
import '../data/impl/phone_impl.dart';
import '../data/network/phone_api_service.dart';

class PhoneRepo {
  PhoneApiService phoneApiService = PhoneImpl();

  Future<dynamic> sendOtpRepo(Map<String, dynamic> params) async {
    dynamic responseData = await phoneApiService.sendOtpPhone(ApiConstant.sendOtpPhone, params);
    return responseData = responseData.data;
  }

  Future<Map<String, dynamic>> verifyOtpRepo(Map<String, dynamic> params) async {
    final response = await phoneApiService.verifyOtpPhone(ApiConstant.verifyOtpPhone, params);
    return response;
  }
}