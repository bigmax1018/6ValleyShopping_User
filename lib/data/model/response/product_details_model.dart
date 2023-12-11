import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';

class ProductDetailsModel {
  int? _id;
  String? _addedBy;
  int? _userId;
  String? _name;
  String? _slug;
  String? _productType;
  List<CategoryIds>? _categoryIds;
  int? _brandId;
  String? _unit;
  int? _minQty;
  int? _refundable;
  String? _digitalProductType;
  String? _digitalFileReady;
  List<String>? _images;
  List<ColorImage>? _colorImage;
  String? _thumbnail;
  int? _featured;
  String? _videoProvider;
  String? _videoUrl;
  List<Colors>? _colors;
  int? _variantProduct;
  List<int>? _attributes;
  List<ChoiceOptions>? _choiceOptions;
  List<Variation>? _variation;
  int? _published;
  double? _unitPrice;
  double? _purchasePrice;
  double? _tax;
  String? _taxModel;
  String? _taxType;
  double? _discount;
  String? _discountType;
  int? _currentStock;
  int? _minimumOrderQty;
  String? _details;
  int? _freeShipping;
  String? _createdAt;
  String? _updatedAt;
  int? _status;
  int? _featuredStatus;
  String? _metaTitle;
  String? _metaDescription;
  String? _metaImage;
  int? _requestStatus;
  String? _deniedNote;
  double? _shippingCost;
  int? _multiplyQty;
  String? _code;
  int? _reviewsCount;
  String? _averageReview;
  List<Reviews>? _reviews;
  Seller? _seller;
  int? wishList;


  ProductDetailsModel(
      {int? id,
        String? addedBy,
        int? userId,
        String? name,
        String? slug,
        String? productType,
        List<CategoryIds>? categoryIds,
        int? brandId,
        String? unit,
        int? minQty,
        int? refundable,
        String? digitalProductType,
        String? digitalFileReady,
        List<String>? images,
        List<ColorImage>? colorImage,
        String? thumbnail,
        int? featured,
        String? videoProvider,
        String? videoUrl,
        List<Colors>? colors,
        int? variantProduct,
        List<int>? attributes,
        List<ChoiceOptions>? choiceOptions,
        List<Variation>? variation,
        int? published,
        double? unitPrice,
        double? purchasePrice,
        double? tax,
        String? taxModel,
        String? taxType,
        double? discount,
        String? discountType,
        int? currentStock,
        int? minimumOrderQty,
        String? details,
        int? freeShipping,
        String? createdAt,
        String? updatedAt,
        int? status,
        int? featuredStatus,
        String? metaTitle,
        String? metaDescription,
        String? metaImage,
        int? requestStatus,
        String? deniedNote,
        double? shippingCost,
        int? multiplyQty,
        String? code,
        int? reviewsCount,
        String? averageReview,
        List<Reviews>? reviews,
        Seller? seller,
        int? wishList,
      }) {
    if (id != null) {
      _id = id;
    }
    if (addedBy != null) {
      _addedBy = addedBy;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (name != null) {
      _name = name;
    }
    if (slug != null) {
      _slug = slug;
    }
    if (productType != null) {
      _productType = productType;
    }
    if (categoryIds != null) {
      _categoryIds = categoryIds;
    }
    if (brandId != null) {
      _brandId = brandId;
    }
    if (unit != null) {
      _unit = unit;
    }
    if (minQty != null) {
      _minQty = minQty;
    }
    if (refundable != null) {
      _refundable = refundable;
    }
    if (digitalProductType != null) {
      _digitalProductType = digitalProductType;
    }
    if (digitalFileReady != null) {
      _digitalFileReady = digitalFileReady;
    }
    if (images != null) {
      _images = images;
    }
    if (colorImage != null) {
      _colorImage = colorImage;
    }
    if (thumbnail != null) {
      _thumbnail = thumbnail;
    }
    if (featured != null) {
      _featured = featured;
    }

    if (videoProvider != null) {
      _videoProvider = videoProvider;
    }
    if (videoUrl != null) {
      _videoUrl = videoUrl;
    }
    if (colors != null) {
      _colors = colors;
    }
    if (variantProduct != null) {
      _variantProduct = variantProduct;
    }
    if (attributes != null) {
      _attributes = attributes;
    }
    if (choiceOptions != null) {
      _choiceOptions = choiceOptions;
    }
    if (variation != null) {
      _variation = variation;
    }
    if (published != null) {
      _published = published;
    }
    if (unitPrice != null) {
      _unitPrice = unitPrice;
    }
    if (purchasePrice != null) {
      _purchasePrice = purchasePrice;
    }
    if (tax != null) {
      _tax = tax;
    }
    if (taxModel != null) {
      _taxModel = taxModel;
    }
    if (taxType != null) {
      _taxType = taxType;
    }
    if (discount != null) {
      _discount = discount;
    }
    if (discountType != null) {
      _discountType = discountType;
    }
    if (currentStock != null) {
      _currentStock = currentStock;
    }
    if (minimumOrderQty != null) {
      _minimumOrderQty = minimumOrderQty;
    }
    if (details != null) {
      _details = details;
    }
    if (freeShipping != null) {
      _freeShipping = freeShipping;
    }

    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (status != null) {
      _status = status;
    }
    if (featuredStatus != null) {
      _featuredStatus = featuredStatus;
    }
    if (metaTitle != null) {
      _metaTitle = metaTitle;
    }
    if (metaDescription != null) {
      _metaDescription = metaDescription;
    }
    if (metaImage != null) {
      _metaImage = metaImage;
    }
    if (requestStatus != null) {
      _requestStatus = requestStatus;
    }
    if (deniedNote != null) {
      _deniedNote = deniedNote;
    }
    if (shippingCost != null) {
      _shippingCost = shippingCost;
    }
    if (multiplyQty != null) {
      _multiplyQty = multiplyQty;
    }
    if (code != null) {
      _code = code;
    }
    if (reviewsCount != null) {
      _reviewsCount = reviewsCount;
    }
    if (averageReview != null) {
      _averageReview = averageReview;
    }
    if (reviews != null) {
      _reviews = reviews;
    }
    if (seller != null) {
      _seller = seller;
    }
    this.wishList;

  }

  int? get id => _id;
  String? get addedBy => _addedBy;
  int? get userId => _userId;
  String? get name => _name;
  String? get slug => _slug;
  String? get productType => _productType;
  List<CategoryIds>? get categoryIds => _categoryIds;
  int? get brandId => _brandId;
  String? get unit => _unit;
  int? get minQty => _minQty;
  int? get refundable => _refundable;
  String? get digitalProductType => _digitalProductType;
  String? get digitalFileReady => _digitalFileReady;
  List<String>? get images => _images;
  List<ColorImage>? get colorImage => _colorImage;
  String? get thumbnail => _thumbnail;
  int? get featured => _featured;
  String? get videoProvider => _videoProvider;
  String? get videoUrl => _videoUrl;
  List<Colors>? get colors => _colors;
  int? get variantProduct => _variantProduct;
  List<int>? get attributes => _attributes;
  List<ChoiceOptions>? get choiceOptions => _choiceOptions;
  List<Variation>? get variation => _variation;
  int? get published => _published;
  double? get unitPrice => _unitPrice;
  double? get purchasePrice => _purchasePrice;
  double? get tax => _tax;
  String? get taxModel => _taxModel;
  String? get taxType => _taxType;
  double? get discount => _discount;
  String? get discountType => _discountType;
  int? get currentStock => _currentStock;
  int? get minimumOrderQty => _minimumOrderQty;
  String? get details => _details;
  int? get freeShipping => _freeShipping;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get status => _status;
  int? get featuredStatus => _featuredStatus;
  String? get metaTitle => _metaTitle;
  String? get metaDescription => _metaDescription;
  String? get metaImage => _metaImage;
  int? get requestStatus => _requestStatus;
  String? get deniedNote => _deniedNote;
  double? get shippingCost => _shippingCost;
  int? get multiplyQty => _multiplyQty;
  String? get code => _code;
  int? get reviewsCount => _reviewsCount;
  String? get averageReview => _averageReview;
  List<Reviews>? get reviews => _reviews;
  Seller? get seller => _seller;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addedBy = json['added_by'];
    _userId = json['user_id'];
    _name = json['name'];
    _slug = json['slug'];
    _productType = json['product_type'];
    if (json['category_ids'] != null) {
      _categoryIds = <CategoryIds>[];
      json['category_ids'].forEach((v) {
        _categoryIds!.add(CategoryIds.fromJson(v));
      });
    }
    _brandId = json['brand_id'];
    _unit = json['unit'];
    _minQty = json['min_qty'];
    _refundable = json['refundable'];
    _digitalProductType = json['digital_product_type'];
    _digitalFileReady = json['digital_file_ready'];
    _images = json['images'].cast<String>();
    if (json['color_image'] != null) {
      _colorImage = <ColorImage>[];
      json['color_image'].forEach((v) {
        _colorImage!.add(ColorImage.fromJson(v));
      });
    }
    _thumbnail = json['thumbnail'];
    _featured = json['featured'];
    _videoProvider = json['video_provider'];
    _videoUrl = json['video_url'];
    if (json['colors_formatted'] != null) {
      _colors = <Colors>[];
      json['colors_formatted'].forEach((v) {
        _colors!.add(Colors.fromJson(v));
      });
    }
    _variantProduct = int.parse(json['variant_product'].toString());
    _attributes = json['attributes'].cast<int>();
    if (json['choice_options'] != null) {
      _choiceOptions = <ChoiceOptions>[];
      json['choice_options'].forEach((v) {
        _choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      _variation = <Variation>[];
      json['variation'].forEach((v) {
        _variation!.add(Variation.fromJson(v));
      });
    }
    _published = json['published'];
    _unitPrice = json['unit_price'].toDouble();
    _purchasePrice = json['purchase_price'].toDouble();
    _tax = json['tax'].toDouble();
    _taxModel = json['tax_model'];
    _taxType = json['tax_type'];
    _discount = json['discount'].toDouble();
    _discountType = json['discount_type'];
    _currentStock = json['current_stock'];
    if(json['minimum_order_qty'] != null){
      _minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
    }else{
      _minimumOrderQty = 1;
    }

    _details = json['details'];
    _freeShipping = json['free_shipping'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _status = json['status'];
    _featuredStatus = json['featured_status'];
    _metaTitle = json['meta_title'];
    _metaDescription = json['meta_description'];
    _metaImage = json['meta_image'];
    _requestStatus = int.parse(json['request_status'].toString());
    _deniedNote = json['denied_note'];
    _shippingCost = json['shipping_cost'].toDouble();
    _multiplyQty = json['multiply_qty'];
    _code = json['code'];
    _reviewsCount = int.parse(json['reviews_count'].toString());
    _averageReview = json['average_review'].toString();
    if (json['reviews'] != null) {
      _reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        _reviews!.add(Reviews.fromJson(v));
      });
    }
    _seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    if(json['wish_list_count'] != null){
      try{
        wishList = json['wish_list_count'];
      }catch(e){
        wishList = int.parse(json['wish_list_count'].toString());
      }

    }
  }

}

class CategoryIds {
  String? _id;
  int? _position;

  CategoryIds({String? id, int? position}) {
    if (id != null) {
      _id = id;
    }
    if (position != null) {
      _position = position;
    }
  }

  String? get id => _id;
  int? get position => _position;


  CategoryIds.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['position'] = _position;
    return data;
  }
}

class Colors {
  String? _name;
  String? _code;

  Colors({String? name, String? code}) {
    if (name != null) {
      _name = name;
    }
    if (code != null) {
      _code = code;
    }
  }

  String? get name => _name;
  String? get code => _code;


  Colors.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['code'] = _code;
    return data;
  }
}



class Reviews {
  int? _id;
  int? _productId;
  int? _customerId;
  String? _comment;
  String? _attachment;
  int? _rating;
  int? _status;
  String? _createdAt;
  String? _updatedAt;
  Customer? _customer;

  Reviews(
      {int? id,
        int? productId,
        int? customerId,
        String? comment,
        String? attachment,
        int? rating,
        int? status,
        String? createdAt,
        String? updatedAt,
        Customer? customer}) {
    if (id != null) {
      _id = id;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (customerId != null) {
      _customerId = customerId;
    }
    if (comment != null) {
      _comment = comment;
    }
    if (attachment != null) {
      _attachment = attachment;
    }
    if (rating != null) {
      _rating = rating;
    }
    if (status != null) {
      _status = status;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (customer != null) {
      _customer = customer;
    }
  }

  int? get id => _id;
  int? get productId => _productId;
  int? get customerId => _customerId;
  String? get comment => _comment;
  String? get attachment => _attachment;
  int? get rating => _rating;
  int? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Customer? get customer => _customer;


  Reviews.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _productId = json['product_id'];
    _customerId = json['customer_id'];
    _comment = json['comment'];
    _attachment = json['attachment'];
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
    data['attachment'] = _attachment;
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
  String? _fName;
  String? _lName;
  String? _phone;
  String? _image;
  String? _email;

  Customer(
      {int? id,
        String? fName,
        String? lName,
        String? phone,
        String? image,
        String? email,
      }) {
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
    if (email != null) {
      _email = email;
    }

  }

  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get image => _image;
  String? get email => _email;


  Customer.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _image = json['image'];
    _email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['image'] = _image;
    data['email'] = _email;

    return data;
  }
}


class ColorImage {
  String? color;
  String? imageName;

  ColorImage({String? color, String? imageName}) {
    if (color != null) {
      color = color;
    }
    if (imageName != null) {
      imageName = imageName;
    }
  }

  ColorImage.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    imageName = json['image_name'];
  }

}
