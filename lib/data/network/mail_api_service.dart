abstract class MailApiService {
  Future<dynamic> sendOtpMail(String url,Map<String, dynamic> params);

  Future<dynamic> verifyOtpMail(String url, Map<String, dynamic> params);
}