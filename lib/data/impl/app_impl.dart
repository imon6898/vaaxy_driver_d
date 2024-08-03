
import 'package:vaaxy_driver/core/domain/api_service.dart';
import 'package:vaaxy_driver/data/network/app_api_service.dart';

class AppImpl extends AppApiService {
  @override
  Future getGallery(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getOffer(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getPassPrice(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getQRCodeCollectionPoint(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getTransactionHistory(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future getUsageHistory(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

}
