import '../core/domain/api_const.dart';
import '../core/domain/api_service.dart';
import '../data/impl/auth_impl.dart';
import '../data/network/auth_api_service.dart';


class AuthRepo {
  final AuthApiService _authApiService = AuthImpl(); // Use the implementation

  /// Phone OTP send and verify
  Future<dynamic> sendOtpPhoneRepo(Map<String, dynamic> params) async {
    final responseData = await _authApiService.sendOtpPhone(ApiConstant.sendOtpPhone, params);
    return responseData;
  }

  Future<dynamic> verifyOtpPhoneRepo(Map<String, dynamic> params) async {
    final responseData = await _authApiService.verifyOtpPhone(ApiConstant.verifyOtpPhone, params);
    return responseData;
  }

  /// Mail OTP send and verify
  Future<dynamic> sendOtpMailRepo(Map<String, dynamic> params) async {
    final responseData = await _authApiService.sendOtpMail(ApiConstant.sendOtpMail, params);
    return responseData;
  }

  Future<dynamic> verifyOtpMailRepo(Map<String, dynamic> params) async {
    final responseData = await _authApiService.verifyOtpMail(ApiConstant.verifyOtpMail, params);
    return responseData;
  }


  /// Sign in for drivers
  Future<dynamic> signInDriverRepo(Map<String, dynamic> params) async {
    final responseData = await _authApiService.signInDriver(ApiConstant.signInDriver, params);
    return responseData;
  }
}
