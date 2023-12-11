class ChosenShippingMethodModel {
  int? _id;
  String? _cartGroupId;
  int? _shippingMethodId;
  double? _shippingCost;
  String? _createdAt;
  String? _updatedAt;

  ChosenShippingMethodModel(
      {int? id,
        String? cartGroupId,
        int? shippingMethodId,
        double? shippingCost,
        String? createdAt,
        String? updatedAt}) {
    _id = id;
    _cartGroupId = cartGroupId;
    _shippingMethodId = shippingMethodId;
    _shippingCost = shippingCost;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  String? get cartGroupId => _cartGroupId;
  int? get shippingMethodId => _shippingMethodId;
  double? get shippingCost => _shippingCost;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ChosenShippingMethodModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _cartGroupId = json['cart_group_id'];
    _shippingMethodId = int.parse(json['shipping_method_id'].toString());
    _shippingCost = double.parse(json['shipping_cost'].toString());
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['cart_group_id'] = _cartGroupId;
    data['shipping_method_id'] = _shippingMethodId;
    data['shipping_cost'] = _shippingCost;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
