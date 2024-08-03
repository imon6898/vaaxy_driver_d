import 'package:vaaxy_driver/core/domain/api_const.dart';

import '../data/impl/my_profile_impl.dart';
import '../data/network/my_profile_api_service.dart';

class MyProfileRepo {
  MyProfileApiService myProfileApiService = MyProfileImpl();

  Future<dynamic>? getMyProfileRepo() async {
    dynamic responseData = await myProfileApiService.getMyProfile(ApiConstant.endPointGetMyProfile);
    return responseData = responseData.data;
  }

}
