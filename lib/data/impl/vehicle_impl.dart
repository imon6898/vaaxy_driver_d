
import 'package:vaaxy_driver/core/domain/api_service.dart';
import 'package:vaaxy_driver/data/network/vehicle_api_service.dart';

class VehicleImpl extends VehicleApiService {

  @override
  Future getVehicle(String url) async {
    dynamic response = await ApiService().get(url);
    return response;
  }

  @override
  Future storeVehicle(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

  @override
  Future deleteVehicle(String url) async {
    dynamic response = await ApiService().delete(url);
    return response;
  }
}
