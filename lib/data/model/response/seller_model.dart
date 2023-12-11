class SellerModel {
  Seller? _seller;
  String? _avgRating;
  int? _totalReview;
  int? _totalOrder;
  int? _totalProduct;
  double? minimumOrderAmount;

  SellerModel(
      {Seller? seller, String? avgRating, int? totalReview, int? totalOrder, int? totalProduct, double? minimumOrderAmount}) {
    if (seller != null) {
      _seller = seller;
    }
    if (avgRating != null) {
      _avgRating = avgRating;
    }
    if (totalReview != null) {
      _totalReview = totalReview;
    }
    if (totalOrder != null) {
      _totalOrder = totalOrder;
    }
    if (totalProduct != null) {
      _totalProduct = totalProduct;
    }
    if (minimumOrderAmount != null) {
      minimumOrderAmount = minimumOrderAmount;
    }
  }

  Seller? get seller => _seller;
  String? get avgRating => _avgRating;
  int? get totalReview => _totalReview;
  int? get totalOrder => _totalOrder;
  int? get totalProduct => _totalProduct;


  SellerModel.fromJson(Map<String, dynamic> json) {
    _seller =
    json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    _avgRating = json['avg_rating'].toString();
    _totalReview = json['total_review'];
    _totalOrder = json['total_order'];
    _totalProduct = json['total_product'];
    if(json['minimum_order_amount'] != null){
      try{
        minimumOrderAmount = json['minimum_order_amount'].toDouble();
      }catch(e){
        minimumOrderAmount = double.parse(json['minimum_order_amount'].toString());
      }
    }else{
      minimumOrderAmount = 0;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_seller != null) {
      data['seller'] = _seller!.toJson();
    }
    data['avg_rating'] = _avgRating;
    data['total_review'] = _totalReview;
    data['total_order'] = _totalOrder;
    data['total_product'] = _totalProduct;
    return data;
  }
}

class Seller {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  Shop? _shop;

  Seller(
      {int? id,
        String? fName,
        String? lName,
        String? phone,
        String? image,
        Shop? shop}) {
    if (id != null) {
      _id = id;
    }
    if (fName != null) {
      _fName = fName;
    }
    if (lName != null) {
      _lName = lName;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (image != null) {
      _image = image;
    }
    if (shop != null) {
      _shop = shop;
    }
  }

  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  Shop? get shop => _shop;

  Seller.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['image'] = _image;
    if (_shop != null) {
      data['shop'] = _shop!.toJson();
    }
    return data;
  }
}

class Shop {
  int? _id;
  int? _sellerId;
  String? _name;
  String? _address;
  String? _contact;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  String? _banner;
  int? _temporaryClose;
  String? _vacationEndDate;
  String? _vacationStartDate;
  int? _vacationStatus;

  Shop(
      {int? id,
        int? sellerId,
        String? name,
        String? address,
        String? contact,
        String? image,
        String? createdAt,
        String? updatedAt,
        String? banner,
        int? temporaryClose,
        String? vacationEndDate,
        String? vacationStartDate,
        int? vacationStatus
      }) {
    if (id != null) {
      _id = id;
    }
    if (sellerId != null) {
      _sellerId = sellerId;
    }
    if (name != null) {
      _name = name;
    }
    if (address != null) {
      _address = address;
    }
    if (contact != null) {
      _contact = contact;
    }
    if (image != null) {
      _image = image;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (banner != null) {
      _banner = banner;
    }
    _temporaryClose = temporaryClose;
    _vacationEndDate = vacationEndDate;
    _vacationStartDate = vacationStartDate;
    _vacationStatus = vacationStatus;
  }

  int? get id => _id;
  int? get sellerId => _sellerId;
  String? get name => _name;
  String? get address => _address;
  String? get contact => _contact;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get banner => _banner;
  int? get temporaryClose => _temporaryClose;
  String? get vacationEndDate => _vacationEndDate;
  String? get vacationStartDate => _vacationStartDate;
  int? get vacationStatus => _vacationStatus;


  Shop.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sellerId = int.parse(json['seller_id'].toString());
    _name = json['name'];
    _address = json['address'];
    _contact = json['contact'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _banner = json['banner'];
    _temporaryClose = json['temporary_close'] != null? int.parse(json['temporary_close'].toString()):0;
    _vacationEndDate = json['vacation_end_date'];
    _vacationStartDate = json['vacation_start_date'];
    _vacationStatus = json['vacation_status'] != null? int.parse(json['vacation_status'].toString()):0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['seller_id'] = _sellerId;
    data['name'] = _name;
    data['address'] = _address;
    data['contact'] = _contact;
    data['image'] = _image;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['banner'] = _banner;
    data['temporary_close'] = _temporaryClose;
    data['vacation_end_date'] = _vacationEndDate;
    data['vacation_start_date'] = _vacationEndDate;
    data['vacation_status'] = _vacationStatus;

    return data;
  }
}
