class SubmitOTPResponseModel {
  Data? data;
  String? message;
  int? code;

  SubmitOTPResponseModel({this.data, this.message, this.code});

  SubmitOTPResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    code = int.parse(json['code'].toString());
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
  String? token;
  String? name;
  String? phone;
  String? redirectTo;

  Data({this.token, this.name, this.phone, this.redirectTo});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    phone = json['phone'];
    redirectTo = json['redirect_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['phone'] = phone;
    data['redirect_to'] = redirectTo;
    return data;
  }
}
