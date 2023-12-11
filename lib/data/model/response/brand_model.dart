class BrandModel {
  int? _id;
  String? _name;
  String? _image;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  int? _brandProductsCount;
  bool? checked;


  BrandModel(
      {int? id,
        String? name,
        String? image,
        int? status,
        String? createdAt,
        String? updatedAt,
        int? brandProductsCount,
        bool? checked,

      }) {
    _id = id;
    _name = name;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _brandProductsCount = brandProductsCount;
    checked = checked;

  }

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get brandProductsCount => _brandProductsCount;


  BrandModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _brandProductsCount = json['brand_products_count'];
    checked = false;

  }

}
