import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';

class OrderModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Orders>? orders;

  OrderModel({this.totalSize, this.limit, this.offset, this.orders});

  OrderModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

}

class Orders {
  int? id;
  int? customerId;
  int? isGuest;
  String? customerType;
  String? paymentStatus;
  String? orderStatus;
  String? paymentMethod;
  String? transactionRef;
  String? paymentBy;
  String? paymentNote;
  double? orderAmount;
  String? adminCommission;
  String? isPause;
  String? cause;
  int? shippingAddress;
  String? createdAt;
  String? updatedAt;
  double? discountAmount;
  String? discountType;
  String? couponCode;
  String? couponDiscountBearer;
  int? shippingMethodId;
  double? shippingCost;
  int? isShippingFree;
  String? orderGroupId;
  String? verificationCode;
  int? verificationStatus;
  int? sellerId;
  String? sellerIs;
  ShippingAddressData? shippingAddressData;
  int? deliveryManId;
  double? deliverymanCharge;
  String? expectedDeliveryDate;
  String? orderNote;
  int? billingAddress;
  BillingAddressData? billingAddressData;
  String? orderType;
  double? extraDiscount;
  String? extraDiscountType;
  String? freeDeliveryBearer;
  int? checked;
  String? shippingType;
  String? deliveryType;
  String? deliveryServiceName;
  String? thirdPartyDeliveryTrackingId;
  int? orderDetailsCount;
  List<Details>? details;
  DeliveryMan? deliveryMan;
  Seller? seller;

  Orders(
      {this.id,
        this.customerId,
        this.isGuest,
        this.customerType,
        this.paymentStatus,
        this.orderStatus,
        this.paymentMethod,
        this.transactionRef,
        this.paymentBy,
        this.paymentNote,
        this.orderAmount,
        this.adminCommission,
        this.isPause,
        this.cause,
        this.shippingAddress,
        this.createdAt,
        this.updatedAt,
        this.discountAmount,
        this.discountType,
        this.couponCode,
        this.couponDiscountBearer,
        this.shippingMethodId,
        this.shippingCost,
        this.isShippingFree,
        this.orderGroupId,
        this.verificationCode,
        this.verificationStatus,
        this.sellerId,
        this.sellerIs,
        this.shippingAddressData,
        this.deliveryManId,
        this.deliverymanCharge,
        this.expectedDeliveryDate,
        this.orderNote,
        this.billingAddress,
        this.billingAddressData,
        this.orderType,
        this.extraDiscount,
        this.extraDiscountType,
        this.freeDeliveryBearer,
        this.checked,
        this.shippingType,
        this.deliveryType,
        this.deliveryServiceName,
        this.thirdPartyDeliveryTrackingId,
        this.orderDetailsCount,
        this.details,
        this.deliveryMan,
        this.seller});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    if(json['temporary_close'] != null){
      isGuest = int.parse(json['temporary_close'].toString());
    }else{
      isGuest = 0;
    }

    customerType = json['customer_type'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    paymentMethod = json['payment_method'];
    transactionRef = json['transaction_ref'];
    paymentBy = json['payment_by'];
    paymentNote = json['payment_note'];
    orderAmount = json['order_amount'].toDouble();
    adminCommission = json['admin_commission'];
    isPause = json['is_pause'];
    cause = json['cause'];
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discountAmount = json['discount_amount'].toDouble();
    discountType = json['discount_type'];
    couponCode = json['coupon_code'];
    couponDiscountBearer = json['coupon_discount_bearer'];
    shippingMethodId = json['shipping_method_id'];
    shippingCost = json['shipping_cost'].toDouble();
    isShippingFree = int.parse(json['is_shipping_free'].toString());
    orderGroupId = json['order_group_id'];
    verificationCode = json['verification_code'];
    verificationStatus = int.parse(json['verification_status'].toString());
    sellerId = json['seller_id'];
    sellerIs = json['seller_is'];
    shippingAddressData = json['shipping_address_data'] != null ? ShippingAddressData.fromJson(json['shipping_address_data']) : null;
    deliveryManId = json['delivery_man_id'];
    if(json['deliveryman_charge'] != null){
      deliverymanCharge = double.parse(json['deliveryman_charge'].toString());
    }else{
      deliverymanCharge = 0;
    }

    expectedDeliveryDate = json['expected_delivery_date'];
    orderNote = json['order_note'];
    billingAddress = json['billing_address'];
    billingAddressData = json['billing_address_data'] != null ? BillingAddressData.fromJson(json['billing_address_data']) : null;
    orderType = json['order_type'];
    extraDiscount = json['extra_discount'].toDouble();
    extraDiscountType = json['extra_discount_type'];
    freeDeliveryBearer = json['free_delivery_bearer'];
    checked = int.parse( json['checked'].toString());
    shippingType = json['shipping_type'];
    deliveryType = json['delivery_type'];
    deliveryServiceName = json['delivery_service_name'];
    thirdPartyDeliveryTrackingId = json['third_party_delivery_tracking_id'];
    if(json['order_details_count'] != null){
      orderDetailsCount = int.parse(json['order_details_count'].toString());
    }else{
      orderDetailsCount = 0;
    }

    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    deliveryMan = json['delivery_man'] != null ? DeliveryMan.fromJson(json['delivery_man']) : null;
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

}


class BillingAddressData {
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
  String? country;
  String? latitude;
  String? longitude;
  int? isBilling;

  BillingAddressData(
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
        this.country,
        this.latitude,
        this.longitude,
        this.isBilling});

  BillingAddressData.fromJson(Map<String, dynamic> json) {
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
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isBilling = json['is_billing'];
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
    data['country'] = country;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['is_billing'] = isBilling;
    return data;
  }
}

class ShippingAddressData {
  int? _id;
  int? _customerId;
  String? _contactPersonName;
  String? _addressType;
  String? _address;
  String? _city;
  String? _zip;
  String? _phone;
  String? _createdAt;
  String? _updatedAt;
  String? _country;

  ShippingAddressData(
      {int? id,
        int? customerId,
        String? contactPersonName,
        String? addressType,
        String? address,
        String? city,
        String? zip,
        String? phone,
        String? createdAt,
        String? updatedAt,
        void state,
        String? country}) {
    if (id != null) {
      _id = id;
    }
    if (customerId != null) {
      _customerId = customerId;
    }
    if (contactPersonName != null) {
      _contactPersonName = contactPersonName;
    }
    if (addressType != null) {
      _addressType = addressType;
    }
    if (address != null) {
      _address = address;
    }
    if (city != null) {
      _city = city;
    }
    if (zip != null) {
      _zip = zip;
    }
    if (phone != null) {
      _phone = phone;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }

    if (country != null) {
      _country = country;
    }
  }

  int? get id => _id;
  int? get customerId => _customerId;
  String? get contactPersonName => _contactPersonName;
  String? get addressType => _addressType;
  String? get address => _address;
  String? get city => _city;
  String? get zip => _zip;
  String? get phone => _phone;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get country => _country;


  ShippingAddressData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _contactPersonName = json['contact_person_name'];
    _addressType = json['address_type'];
    _address = json['address'];
    _city = json['city'];
    _zip = json['zip'];
    _phone = json['phone'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['customer_id'] = _customerId;
    data['contact_person_name'] = _contactPersonName;
    data['address_type'] = _addressType;
    data['address'] = _address;
    data['city'] = _city;
    data['zip'] = _zip;
    data['phone'] = _phone;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    data['country'] = _country;
    return data;
  }
}

class DeliveryMan {
  int? _id;
  String? _fName;
  String? _lName;
  String? _phone;
  String? _email;
  String? _image;
  DeliveryMan(
      {
        int? id,
        String? fName,
        String? lName,
        String? phone,
        String? email,
        String? image
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
    if (email != null) {
      _email = email;
    }

    if (image != null) {
      _image = image;
    }

  }


  int? get id => _id;
  String? get fName => _fName;
  String? get lName => _lName;
  String? get phone => _phone;
  String? get email => _email;
  String? get image => _image;

  DeliveryMan.fromJson(Map<String, dynamic> json) {

    _id = json['id'];
    _fName = json['f_name'];
    _lName = json['l_name'];
    _phone = json['phone'];
    _email = json['email'];
    _image = json['image'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = _id;
    data['f_name'] = _fName;
    data['l_name'] = _lName;
    data['phone'] = _phone;
    data['email'] = _email;
    data['image'] = _image;
    return data;
  }
}



class Shop {
  String? image;
  String? name;
  Shop(
      {this.image, this.name});

  Shop.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }
}


class Details {
  Product? product;

  Details(
      {this.product});

  Details.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}

class Product {
  String? thumbnail;
  String? productType;


  Product(
      {this.thumbnail, this.productType});

  Product.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    productType = json['product_type'];

  }


}
