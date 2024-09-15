import 'package:vaaxy_driver/core/domain/api_service.dart';

import '../network/support_api_service.dart';

class SupportImpl extends SupportApiService {
  @override
  Future addSupport(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

  @override
  Future getAllSupport(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getContactInfo(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getSupportDetails(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

}