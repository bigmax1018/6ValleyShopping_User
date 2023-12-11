class SocialLoginModel {
  String? token;
  String? uniqueId;
  String? medium;
  String? email;

  SocialLoginModel({this.token, this.uniqueId, this.medium, this.email});

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    uniqueId = json['unique_id'];
    medium = json['medium'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['unique_id'] = uniqueId;
    data['medium'] = medium;
    data['email'] = email;
    return data;
  }
}
