import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/data/impl/support_impl.dart';
import 'package:vaaxy_driver/data/network/support_api_service.dart';

class SupportRepo {
  SupportApiService supportApiService = SupportImpl();

  Future<dynamic>? addSupportRepo(Map<String, dynamic> params) async {
    dynamic responseData = await supportApiService.addSupport(ApiConstant.endPointAddSupport, params);
    return responseData = responseData.data;
  }

  Future<dynamic>? getAllSupportRepo() async {
    dynamic responseData = await supportApiService.getAllSupport(ApiConstant.endPointGetAllSupport);
    return responseData = responseData.data;
  }

  Future<dynamic>? getContactInfoRepo() async {
    dynamic responseData = await supportApiService.getContactInfo(ApiConstant.endPointGetContactInfo);
    return responseData = responseData.data;
  }

  Future<dynamic>? getSupportDetailsRepo(String supportID) async {
    dynamic responseData = await supportApiService.getSupportDetails(ApiConstant.endPointGetGetSupportDetails.replaceAll("#supportId#", supportID));
    return responseData = responseData.data;
  }
}
