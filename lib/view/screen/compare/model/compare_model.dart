import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class CompareModel {
  List<CompareLists>? compareLists;

  CompareModel({this.compareLists});

  CompareModel.fromJson(Map<String, dynamic> json) {
    if (json['compare_lists'] != null) {
      compareLists = <CompareLists>[];
      json['compare_lists'].forEach((v) {
        compareLists!.add(CompareLists.fromJson(v));
      });
    }
  }
}

class CompareLists {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  CompareLists(
      {this.id,
        this.userId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.product});

  CompareLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }


}

