class LoginModel {
  String? email;
  String? password;
  String? guestId;

  LoginModel({this.email, this.password, this.guestId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    guestId = json['guest_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['guest_id'] = guestId;
    return data;
  }
}
