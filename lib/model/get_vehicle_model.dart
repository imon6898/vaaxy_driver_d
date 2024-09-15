class GetVehicleModel {
  Data? data;
  String? message;
  int? code;

  GetVehicleModel({this.data, this.message, this.code});

  GetVehicleModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Data {
  String? vehicleName;
  String? ownerName;
  String? ownerPhone;
  String? zone;
  String? series;
  String? vehicleNumber;
  String? blueBookFront;
  String? blueBookBack;
  String? vehicleChassisNumber;
  int? vehicleTypeId;
  String? status;
  VehicleType? vehicleType;

  Data(
      {this.vehicleName,
        this.ownerName,
        this.ownerPhone,
        this.zone,
        this.series,
        this.vehicleNumber,
        this.blueBookFront,
        this.blueBookBack,
        this.vehicleChassisNumber,
        this.vehicleTypeId,
        this.status,
        this.vehicleType});

  Data.fromJson(Map<String, dynamic> json) {
    vehicleName = json['vehicle_name'];
    ownerName = json['owner_name'];
    ownerPhone = json['owner_phone'];
    zone = json['zone'];
    series = json['series'];
    vehicleNumber = json['vehicle_number'];
    blueBookFront = json['blue_book_front'];
    blueBookBack = json['blue_book_back'];
    vehicleChassisNumber = json['vehicle_chassis_number'];
    vehicleTypeId = json['vehicle_type_id'];
    status = json['status'];
    vehicleType = json['vehicle_type'] != null
        ? new VehicleType.fromJson(json['vehicle_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_name'] = this.vehicleName;
    data['owner_name'] = this.ownerName;
    data['owner_phone'] = this.ownerPhone;
    data['zone'] = this.zone;
    data['series'] = this.series;
    data['vehicle_number'] = this.vehicleNumber;
    data['blue_book_front'] = this.blueBookFront;
    data['blue_book_back'] = this.blueBookBack;
    data['vehicle_chassis_number'] = this.vehicleChassisNumber;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['status'] = this.status;
    if (this.vehicleType != null) {
      data['vehicle_type'] = this.vehicleType!.toJson();
    }
    return data;
  }
}

class VehicleType {
  int? id;
  String? vehicleType;

  VehicleType({this.id, this.vehicleType});

  VehicleType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleType = json['vehicle_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_type'] = this.vehicleType;
    return data;
  }
}
