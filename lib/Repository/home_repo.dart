import '../core/domain/api_const.dart';
import '../data/impl/home_impl.dart';
import '../data/network/home_api_service.dart';

class HomeRepo {
  final HomeApiService _homeApiService = HomeImpl();

  Future<dynamic> goOnlineOfflineRepo(Map<String, dynamic> params) async {
    final responseData = await _homeApiService.goOnlineOffline(ApiConstant.postGoOnline, params);
    return responseData;
  }
}

// class HomeRepo {
//   final HomeApiService _homeApiService = HomeImpl();
//
//   Future<dynamic> goOnlineOfflineRepo(Map<String, dynamic> params) async {
//     final responseData = await _homeApiService.goOnlineOffline(ApiConstant.postGoOnline, params);
//     return responseData;
//   }
// }