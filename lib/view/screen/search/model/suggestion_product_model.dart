class SuggestionModel {
  List<Products>? products;

  SuggestionModel({this.products});

  SuggestionModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

}

class Products {
  int? id;
  String? name;

  Products({this.id, this.name});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}
