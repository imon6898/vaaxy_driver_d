
class ContactInfo {
  String text;
  String phone;
  String email;

  ContactInfo({
    required this.text,
    required this.phone,
    required this.email,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      text: json['text'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}
