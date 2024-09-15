import '../../core/domain/api_service.dart';
import '../network/auth_api_service.dart';


class AuthImpl extends AuthApiService {
  final ApiService _apiService = ApiService();

  @override
  Future<dynamic> sendOtpPhone(String url, Map<String, dynamic> params) async {
    final response = await _apiService.postTrue(url, params);
    return response;
  }

  @override
  Future<dynamic> verifyOtpPhone(String url, Map<String, dynamic> params) async {
    final response = await _apiService.postTrue(url, params);
    return response;
  }

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

  @override
  Future<dynamic> signInDriver(String url, Map<String, dynamic> params) async {
    final response = await _apiService.post(url, params);
    return response;
  }
}
