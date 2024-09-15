class OfferResponseModel {
  List<OfferData>? offerData;
  String? message;
  int? code;

  OfferResponseModel({this.offerData, this.message, this.code});

  OfferResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      offerData = <OfferData>[];
      json['data'].forEach((v) {
        offerData!.add(OfferData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (offerData != null) {
      data['data'] = offerData!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class OfferData {
  int? id;
  String? title;
  String? offerValidity;
  var passValidity;
  int? passes;
  int? bonusPasses;
  int? amount;
  String? banner;
  String? vehicleType;

  OfferData(
      {this.id,
        this.title,
        this.offerValidity,
        this.passValidity,
        this.passes,
        this.bonusPasses,
        this.amount,
        this.banner,
        this.vehicleType});

  OfferData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    offerValidity = json['offer_validity'];
    passValidity = json['pass_validity'];
    passes = json['passes'];
    bonusPasses = json['bonus_passes'];
    amount = json['amount'];
    banner = json['banner'];
    vehicleType = json['vehicle_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['offer_validity'] = offerValidity;
    data['pass_validity'] = passValidity;
    data['passes'] = passes;
    data['bonus_passes'] = bonusPasses;
    data['amount'] = amount;
    data['banner'] = banner;
    data['vehicle_type'] = vehicleType;
    return data;
  }
}
