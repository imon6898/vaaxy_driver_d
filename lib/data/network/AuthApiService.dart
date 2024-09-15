abstract class  AuthApiService {
  Future<dynamic> sendOTPToNumber(String url,Map<String, dynamic> params);
  Future<dynamic> submitOTPWithNumber(String url,Map<String, dynamic> params);
  Future<dynamic> registerNewAccount(String url,Map<String, dynamic> params);
  Future<dynamic> logOutAccount(String url);
}