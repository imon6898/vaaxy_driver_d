class GetMyProfileModel {
  Data? data;
  String? message;
  int? code;

  GetMyProfileModel({this.data, this.message, this.code});

  GetMyProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class Data {
  Profile? profile;

  Data({this.profile});

  Data.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? name;
  String? phone;
  String? email;
  String? dateOfBirth;
  String? gender;
  var avatar;
  var deviceId;
  var deviceToken;
  String? googleId;
  String? appleId;
  Vehicle? vehicle;

  Profile(
      {this.name,
        this.phone,
        this.email,
        this.dateOfBirth,
        this.gender,
        this.avatar,
        this.deviceId,
        this.deviceToken,
        this.googleId,
        this.appleId,
        this.vehicle});

  Profile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    avatar = json['avatar'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    googleId = json['google_id'];
    appleId = json['apple_id'];
    vehicle =
    json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['avatar'] = avatar;
    data['device_id'] = deviceId;
    data['device_token'] = deviceToken;
    data['google_id'] = googleId;
    data['apple_id'] = appleId;
    if (vehicle != null) {
      data['vehicle'] = vehicle!.toJson();
    }
    return data;
  }
}

class Vehicle {
  int? availablePass;
  String? status;
  String? zone;
  String? vehicleNumber;
  String? vehicleType;
  String? vehicleChassisNumber;

  Vehicle(
      {this.availablePass,
        this.status,
        this.zone,
        this.vehicleNumber,
        this.vehicleType,
        this.vehicleChassisNumber});

  Vehicle.fromJson(Map<String, dynamic> json) {
    availablePass = json['available_pass'];
    status = json['status'];
    zone = json['zone'];
    vehicleNumber = json['vehicle_number'];
    vehicleType = json['vehicle_type'];
    vehicleChassisNumber = json['vehicle_chassis_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['available_pass'] = availablePass;
    data['status'] = status;
    data['zone'] = zone;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_type'] = vehicleType;
    data['vehicle_chassis_number'] = vehicleChassisNumber;
    return data;
  }
}
