class QRCodeCollectionModelResponse {
  List<QRCodeData>? qRCodeData;
  String? message;
  int? code;

  QRCodeCollectionModelResponse({this.qRCodeData, this.message, this.code});

  QRCodeCollectionModelResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      qRCodeData = <QRCodeData>[];
      json['data'].forEach((v) {
        qRCodeData!.add(QRCodeData.fromJson(v));
      });
    }
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (qRCodeData != null) {
      data['data'] = qRCodeData!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class QRCodeData {
  String? buildingNumber;
  String? streetName;
  String? streetAddress;
  String? state;
  String? city;
  String? postCode;

  QRCodeData(
      {this.buildingNumber,
        this.streetName,
        this.streetAddress,
        this.state,
        this.city,
        this.postCode});

  QRCodeData.fromJson(Map<String, dynamic> json) {
    buildingNumber = json['Building Number'];
    streetName = json['Street Name'];
    streetAddress = json['Street Address'];
    state = json['State'];
    city = json['City'];
    postCode = json['Post Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Building Number'] = buildingNumber;
    data['Street Name'] = streetName;
    data['Street Address'] = streetAddress;
    data['State'] = state;
    data['City'] = city;
    data['Post Code'] = postCode;
    return data;
  }
}
