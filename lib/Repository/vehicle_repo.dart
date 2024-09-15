import 'package:vaaxy_driver/core/domain/api_const.dart';
import 'package:vaaxy_driver/data/impl/vehicle_impl.dart';
import 'package:vaaxy_driver/data/network/vehicle_api_service.dart';

class VehicleRepo {
  final VehicleApiService _vehicleApiService = VehicleImpl();

  Future<dynamic> getVehiclesRepo() async {
    dynamic responseData = await _vehicleApiService.getVehicle(ApiConstant.endPointGetVehicle);
    return responseData.data;
  }

  Future<dynamic> addVehicleRepo(Map<String, dynamic> params) async {
    dynamic responseData = await _vehicleApiService.storeVehicle(ApiConstant.endPointAddVehicle, params);
    return responseData = responseData.data;
  }

  Future<dynamic> deleteVehicleRepo(String id) async {
    dynamic responseData = await _vehicleApiService.deleteVehicle(ApiConstant.endPointDeleteVehicle);
    return responseData = responseData.data;
  }
}
