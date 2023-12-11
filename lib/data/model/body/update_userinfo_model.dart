class UpdateUserInfoModel {
  String? fName;
  String? lName;
  String? phone;

  UpdateUserInfoModel({
    this.fName,
    this.lName,
    this.phone,
  });

  UpdateUserInfoModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    return data;
  }
}
