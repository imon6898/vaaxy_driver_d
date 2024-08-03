// support_detail_model.dart
import 'dart:convert';

SupportDetailModel supportDetailModelFromJson(String str) => SupportDetailModel.fromJson(json.decode(str));

String supportDetailModelToJson(SupportDetailModel data) => json.encode(data.toJson());

class SupportDetailModel {
  final List<SupportDetailDatum>? data;
  final String? message;
  final int? code;

  SupportDetailModel({
    this.data,
    this.message,
    this.code,
  });

  factory SupportDetailModel.fromJson(Map<String, dynamic> json) => SupportDetailModel(
    data: json["data"] == null ? [] : List<SupportDetailDatum>.from(json["data"]!.map((x) => SupportDetailDatum.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}

class SupportDetailDatum {
  final int? senderableId;
  final String? senderableType;
  final String? message;
  final DateTime? createdAt;
  final Senderable? senderable;

  SupportDetailDatum({
    this.senderableId,
    this.senderableType,
    this.message,
    this.createdAt,
    this.senderable,
  });

  factory SupportDetailDatum.fromJson(Map<String, dynamic> json) => SupportDetailDatum(
    senderableId: json["senderable_id"],
    senderableType: json["senderable_type"],
    message: json["message"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    senderable: json["senderable"] == null ? null : Senderable.fromJson(json["senderable"]),
  );

  Map<String, dynamic> toJson() => {
    "senderable_id": senderableId,
    "senderable_type": senderableType,
    "message": message,
    "created_at": createdAt?.toIso8601String(),
    "senderable": senderable?.toJson(),
  };
}

class Senderable {
  final int? id;
  final String? name;

  Senderable({
    this.id,
    this.name,
  });

  factory Senderable.fromJson(Map<String, dynamic> json) => Senderable(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
