import '../../core/domain/api_service.dart';
import '../network/mail_api_service.dart';

class MailImpl extends MailApiService {

  @override
  Future sendOtpMail(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

  @override
  Future<dynamic> verifyOtpMail(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }
}