import 'dart:convert';


FetchAllSupportModel fetchAllSupportModelFromJson(String str) => FetchAllSupportModel.fromJson(json.decode(str));

String fetchAllSupportModelToJson(FetchAllSupportModel data) => json.encode(data.toJson());

class FetchAllSupportModel {
  final List<Datum>? data;
  final String? message;
  final int? code;

  FetchAllSupportModel({
    this.data,
    this.message,
    this.code,
  });

  factory FetchAllSupportModel.fromJson(Map<String, dynamic> json) => FetchAllSupportModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
  final String? status;
  final DateTime? createdAt;
  final int? messageCount;

  Datum({
    this.id,
    this.title,
    this.status,
    this.createdAt,
    this.messageCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    messageCount: json["message_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "message_count": messageCount,
  };
}
