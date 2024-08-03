import 'dart:convert';

GetOffersModel getOffersModelFromJson(String str) => GetOffersModel.fromJson(json.decode(str));
String getOffersModelToJson(GetOffersModel data) => json.encode(data.toJson());

class GetOffersModel {
  final List<Datum>? data;
  final String? message;
  final int? code;

  GetOffersModel({
    this.data,
    this.message,
    this.code,
  });

  factory GetOffersModel.fromJson(Map<String, dynamic> json) => GetOffersModel(
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
  final int? id;
  final String? title;
  final String? offerValidity;
  final dynamic passValidity;
  final int? passes;
  final int? bonusPasses;
  final int? amount;
  final dynamic banner;
  final VehicleType? vehicleType;

  Datum({
    this.id,
    this.title,
    this.offerValidity,
    this.passValidity,
    this.passes,
    this.bonusPasses,
    this.amount,
    this.banner,
    this.vehicleType,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    offerValidity: json["offer_validity"],
    passValidity: json["pass_validity"],
    passes: json["passes"],
    bonusPasses: json["bonus_passes"],
    amount: json["amount"],
    banner: json["banner"],
    vehicleType: vehicleTypeValues.map[json["vehicle_type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "offer_validity": offerValidity,
    "pass_validity": passValidity,
    "passes": passes,
    "bonus_passes": bonusPasses,
    "amount": amount,
    "banner": banner,
    "vehicle_type": vehicleTypeValues.reverse[vehicleType],
  };
}

enum VehicleType {
  ASPERNATUR,
  ISTE,
  QUI
}

final vehicleTypeValues = EnumValues({
  "aspernatur": VehicleType.ASPERNATUR,
  "iste": VehicleType.ISTE,
  "qui": VehicleType.QUI
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
