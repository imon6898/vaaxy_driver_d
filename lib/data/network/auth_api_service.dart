abstract class AuthApiService {
  /// Phone OTP send and verify
  Future<dynamic> sendOtpPhone(String url, Map<String, dynamic> params);
  Future<dynamic> verifyOtpPhone(String url, Map<String, dynamic> params);

  /// Mail OTP send and verify
  Future<dynamic> sendOtpMail(String url, Map<String, dynamic> params);
  Future<dynamic> verifyOtpMail(String url, Map<String, dynamic> params);

  ///Sign In
  Future<dynamic> signInDriver(String url, Map<String, dynamic> params);
}
