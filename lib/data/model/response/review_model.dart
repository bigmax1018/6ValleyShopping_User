class ReviewModel {
  int? _id;
  int? _productId;
  int? _customerId;
  String? _comment;
  List<String>? _attachment;
  int? _rating;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  Customer? _customer;

  ReviewModel(
      {int? id,
        int? productId,
        int? customerId,
        String? comment,
        List<String>? attachment,
        int? rating,
        int? status,
        String? createdAt,
        String? updatedAt,
        Customer? customer}) {
    _id = id;
    _productId = productId;
    _customerId = customerId;
    _comment = comment;
    _attachment = attachment;
    _rating = rating;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _customer = customer;
  }

  int? get id => _id;
  int? get productId => _productId;
  int? get customerId => _customerId;
  String? get comment => _comment;
  List<String>? get attachment => _attachment;
  int? get rating => _rating;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Customer? get customer => _customer;

  ReviewModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _customerId = json['customer_id'];
    _comment = json['comment'];
    if(json['attachment'] != null){
      _attachment = json['attachment'].cast<String>();
    }

    _rating = json['rating'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['product_id'] = _productId;
    data['customer_id'] = _customerId;
    data['comment'] = _comment;
    if (_customer != null) {
      data['customer'] = _customer!.toJson();
    }
    data['rating'] = _rating;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    if (_customer != null) {
      data['customer'] = _customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? _id;
  String? _name;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  String? _email;
  String? _emailVerifiedAt;
  String? _createdAt;
  String? _updatedAt;
  String? _streetAddress;
  String? _country;
  String? _city;
  String? _zip;
  String? _houseNo;
  String? _apartmentNo;

  Customer(
      {int? id,
        String? name,
        String? fName,
        String? lName,
        String? phone,
        String? image,
        String? email,
        String? emailVerifiedAt,
        String? createdAt,
        String? updatedAt,
        String? streetAddress,
        String? country,
        String? city,
        String? zip,
        String? houseNo,
        String? apartmentNo}) {
    _id = id;
    _name = name;
    _fName = fName;
    _lName = lName;
    _phone = phone;
    _image = image;
    _email = email;
    _emailVerifiedAt = emailVerifiedAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _streetAddress = streetAddress;
    _country = country;
    _city = city;
    _zip = zip;
    _houseNo = houseNo;
    _apartmentNo = apartmentNo;
  }

  int? get id => _id;
  String? get name => _name;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  String? get email => _email;
  String? get emailVerifiedAt => _emailVerifiedAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get streetAddress => _streetAddress;
  String? get country => _country;
  String? get city => _city;
  String? get zip => _zip;
  String? get houseNo => _houseNo;
  String? get apartmentNo => _apartmentNo;

  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _email = json['email'];
    _emailVerifiedAt = json['email_verified_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _streetAddress = json['street_address'];
    _country = json['country'];
    _city = json['city'];
    _zip = json['zip'];
    _houseNo = json['house_no'];
    _apartmentNo = json['apartment_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['image'] = _image;
    data['email'] = _email;
    data['email_verified_at'] = _emailVerifiedAt;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['street_address'] = _streetAddress;
    data['country'] = _country;
    data['city'] = _city;
    data['zip'] = _zip;
    data['house_no'] = _houseNo;
    data['apartment_no'] = _apartmentNo;
    return data;
  }
}