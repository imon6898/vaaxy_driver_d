import 'dart:convert';

QrCollectionPointModel qrCollectionPointModelFromJson(String str) => QrCollectionPointModel.fromJson(json.decode(str));
String qrCollectionPointModelToJson(QrCollectionPointModel data) => json.encode(data.toJson());

class QrCollectionPointModel {
  final List<Datum>? data;
  final String? message;
  final int? code;

  QrCollectionPointModel({
    this.data,
    this.message,
    this.code,
  });

  factory QrCollectionPointModel.fromJson(Map<String, dynamic> json) => QrCollectionPointModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class Datum {
  final String? buildingNumber;
  final String? streetName;
  final String? streetAddress;
  final String? state;
  final String? city;
  final String? postCode;

  Datum({
    this.buildingNumber,
    this.streetName,
    this.streetAddress,
    this.state,
    this.city,
    this.postCode,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    buildingNumber: json["Building Number"],
    streetName: json["Street Name"],
    streetAddress: json["Street Address"],
    state: json["State"],
    city: json["City"],
    postCode: json["Post Code"],
  );

  Map<String, dynamic> toJson() => {
    "Building Number": buildingNumber,
    "Street Name": streetName,
    "Street Address": streetAddress,
    "State": state,
    "City": city,
    "Post Code": postCode,
  };
}
