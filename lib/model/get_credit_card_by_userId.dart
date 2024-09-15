// To parse this JSON data, do
//
//     final getCreditCardByUserIdModel = getCreditCardByUserIdModelFromJson(jsonString);

import 'dart:convert';

GetCreditCardByUserIdModel getCreditCardByUserIdModelFromJson(String str) => GetCreditCardByUserIdModel.fromJson(json.decode(str));

String getCreditCardByUserIdModelToJson(GetCreditCardByUserIdModel data) => json.encode(data.toJson());

class GetCreditCardByUserIdModel {
  final int? id;
  final int? userId;
  final String? cardholderName;
  final String? cardNumber;
  final String? expiDate;
  final int? cardType;
  final String? cardSecurityCode;
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? zipCode;

  GetCreditCardByUserIdModel({
    this.id,
    this.userId,
    this.cardholderName,
    this.cardNumber,
    this.expiDate,
    this.cardType,
    this.cardSecurityCode,
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
  });

  factory GetCreditCardByUserIdModel.fromJson(Map<String, dynamic> json) => GetCreditCardByUserIdModel(
    id: json["id"],
    userId: json["userId"],
    cardholderName: json["cardholderName"],
    cardNumber: json["cardNumber"],
    expiDate: json["expiDate"],
    cardType: json["cardType"],
    cardSecurityCode: json["cardSecurityCode"],
    streetAddress: json["streetAddress"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "cardholderName": cardholderName,
    "cardNumber": cardNumber,
    "expiDate": expiDate,
    "cardType": cardType,
    "cardSecurityCode": cardSecurityCode,
    "streetAddress": streetAddress,
    "city": city,
    "state": state,
    "zipCode": zipCode,
  };
}
