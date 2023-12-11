class MoreStoreModel {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  Shop? shop;

  MoreStoreModel(
      {this.id,
        this.fName,
        this.lName,
        this.phone,
        this.image,
        this.shop});

  MoreStoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }
}

class Shop {
  int? id;
  String? name;
  String? address;
  String? contact;
  String? image;
  String? vacationStartDate;
  String? vacationEndDate;
  String? vacationNote;
  int? vacationStatus;
  int? temporaryClose;
  String? createdAt;
  String? updatedAt;
  String? banner;

  Shop(
      {this.id,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.vacationStartDate,
        this.vacationEndDate,
        this.vacationNote,
        this.vacationStatus,
        this.temporaryClose,
        this.createdAt,
        this.updatedAt,
        this.banner});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    vacationStartDate = json['vacation_start_date'];
    vacationEndDate = json['vacation_end_date'];
    vacationNote = json['vacation_note'];
    vacationStatus = int.parse(json['vacation_status'].toString());
    temporaryClose = int.parse(json['temporary_close'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
  }

}
