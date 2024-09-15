abstract class PhoneApiService {
  Future<dynamic> sendOtpPhone(String url,Map<String, dynamic> params);

  Future<dynamic> verifyOtpPhone(String url, Map<String, dynamic> params);
}