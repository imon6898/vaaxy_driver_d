

import 'package:vaaxy_driver/core/domain/api_service.dart';

import '../network/my_profile_api_service.dart';
import '../network/support_api_service.dart';

class MyProfileImpl extends MyProfileApiService {

  @override
  Future getMyProfile(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

}