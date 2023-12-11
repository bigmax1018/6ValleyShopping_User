import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class HomeCategoryProduct {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? position;
  String? createdAt;
  String? updatedAt;
  List<Product>? products;
  List<dynamic>? translations;

  HomeCategoryProduct(
      {this.id,
        this.name,
        this.slug,
        this.icon,
        this.parentId,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.products,
        this.translations});

  HomeCategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    position = json['position'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) { products!.add(Product.fromJson(v)); });
    }

    if (json['translations'] != null) {
      translations = [];
      translations = List<dynamic>.from(translations!.map((x) => x));
    }

  }

}
