abstract class AuthApiService {
  Future<dynamic> sendOtpPhone(String url, Map<String, dynamic> params);
  Future<dynamic> verifyOtpPhone(String url, Map<String, dynamic> params);

  Future<dynamic> sendOtpMail(String url, Map<String, dynamic> params);
  Future<dynamic> verifyOtpMail(String url, Map<String, dynamic> params);

  Future<dynamic> signInDriver(String url, Map<String, dynamic> params);
}