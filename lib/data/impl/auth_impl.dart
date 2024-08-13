import '../../core/domain/api_service.dart';
import '../network/auth_api_service.dart';


class AuthImpl extends AuthApiService {
  final ApiService _apiService = ApiService();

  /// Phone OTP send and verify
  @override
  Future<dynamic> sendOtpPhone(String url, Map<String, dynamic> params) async {
    final response = await _apiService.post(url, params);
    return response;  // Assuming response is already a parsed dynamic object
  }

  @override
  Future<dynamic> verifyOtpPhone(String url, Map<String, dynamic> params) async {
    final response = await _apiService.post(url, params);
    return response;
  }

  /// Mail OTP send and verify
  @override
  Future<dynamic> sendOtpMail(String url, Map<String, dynamic> params) async {
    final response = await _apiService.postTrue(url, params);
    return response;
  }

  @override
  Future<dynamic> verifyOtpMail(String url, Map<String, dynamic> params) async {
    final response = await _apiService.postTrue(url, params);
    return response;
  }


  /// Sign in for drivers
  @override
  Future<dynamic> signInDriver(String url, Map<String, dynamic> params) async {
    final response = await _apiService.post(url, params);
    return response;
  }

}
