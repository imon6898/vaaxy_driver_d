abstract class  VehicleApiService {
  Future<dynamic> storeVehicle(String url,Map<String, dynamic> params);
  Future<dynamic> getVehicle(String url);
  Future<dynamic> deleteVehicle(String url);
}