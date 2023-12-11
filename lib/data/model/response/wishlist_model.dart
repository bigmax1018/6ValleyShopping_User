import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class WishListModel {
  int? id;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  WishListModel({this.id, this.customerId, this.productId, this.createdAt, this.updatedAt, this.product});

  WishListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

}
