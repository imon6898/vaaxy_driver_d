
import 'package:vaaxy_driver/core/domain/api_const.dart';
import '../data/impl/app_impl.dart';
import '../data/network/app_api_service.dart';

class AppRepo {
  final AppApiService _appApiService = AppImpl();

  ///Driver getCreditCardByUserId
  Future<dynamic>? getCreditCardByUserId(String userId) async {
    // Construct the endpoint URL with the userId
    String endpoint = '${ApiConstant.getCreditCardByUserId}/$userId';
    // Call the API service method with the endpoint
    dynamic responseData = await _appApiService.getCreditCardByUserId(endpoint, {});
    return responseData;
  }
}
