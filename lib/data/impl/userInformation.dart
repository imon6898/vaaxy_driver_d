
import 'package:vaaxy_driver/data/network/userApiService.dart';

import '../../core/domain/api_service.dart';

class UserInformation extends AuthApiService{

  @override
  Future sendOTPToNumber(String url, Map<String, dynamic> params) async {
    dynamic response  = await ApiService().post(url,params);
    return  response;
  }

  @override
  Future submitOTPWithNumber(String url, Map<String, dynamic> params) async {
    dynamic response  = await ApiService().post(url,params);
    return  response;
  }

  @override
  Future registerNewAccount(String url, Map<String, dynamic> params) async {
    dynamic response  = await ApiService().post(url,params);
    return  response;
  }


  @override
  Future logOutAccount(String url) async {
    dynamic response  = await ApiService().get(url);
    return  response;
  }

}