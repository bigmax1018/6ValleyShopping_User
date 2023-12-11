class AddressModel {
  int? id;
  int? customerId;
  String? contactPersonName;
  String? addressType;
  String? address;
  String? city;
  String? zip;
  String? phone;
  String? createdAt;
  String? updatedAt;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;
  String? guestId;
  String? email;

  AddressModel(
      {this.id,
        this.customerId,
        this.contactPersonName,
        this.addressType,
        this.address,
        this.city,
        this.zip,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling,
        this.guestId,
        this.email,
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    contactPersonName = json['contact_person_name'];
    addressType = json['address_type'];
    address = json['address'];
    city = json['city'];
    zip = json['zip'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['contact_person_name'] = contactPersonName;
    data['address_type'] = addressType;
    data['address'] = address;
    data['city'] = city;
    data['zip'] = zip;
    data['phone'] = phone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['state'] = state;
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    data['guest_id'] = guestId;
    data['email'] = email;
    return data;
  }
}
