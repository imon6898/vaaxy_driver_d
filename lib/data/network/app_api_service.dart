abstract class AppApiService {
  // Future<dynamic> storeVehicle(String url,Map<String, dynamic> params);
  Future<dynamic> getOffer(String url);

  Future<dynamic> getPassPrice(String url);

  Future<dynamic> getQRCodeCollectionPoint(String url);

  Future<dynamic> getGallery(String url);

  Future<dynamic> getTransactionHistory(String url);

  Future<dynamic> getUsageHistory(String url);
}
