

import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/data/impl/app_impl.dart';
import 'package:vaaxy_driver/data/network/app_api_service.dart';

class AppRepo {
  AppApiService appApiService = AppImpl();

  Future<dynamic>? getGalleryRepo() async {
    dynamic responseData = await appApiService.getPassPrice(ApiConstant.endPointGeGallery);
    return responseData = responseData.data;
  }

  Future<dynamic>? getOfferRepo() async {
    dynamic responseData = await appApiService.getPassPrice(ApiConstant.endPointGetOffers);
    return responseData = responseData.data;
  }

  Future<dynamic>? getPassPriceRepo(String id) async {
    dynamic responseData = await appApiService.getPassPrice(ApiConstant.endPointGetPassPrice.replaceAll("#passesID#", id));
    return responseData = responseData.data;
  }

  Future<dynamic>? getQRCodeCollectionPointRepo() async {
    dynamic responseData = await appApiService.getQRCodeCollectionPoint(ApiConstant.endPointGetQRCodeCollectionPoint);
    return responseData = responseData.data;
  }

  Future<dynamic>? getTransactionHistoryRepo() async {
    dynamic responseData = await appApiService.getTransactionHistory(ApiConstant.endPointGetTransactionHistory);
    return responseData = responseData.data;
  }

  Future<dynamic>? getUsageHistoryRepo(String supportID) async {
    dynamic responseData = await appApiService.getUsageHistory(ApiConstant.endPointGetUsageHistory);
    return responseData = responseData.data;
  }
}
