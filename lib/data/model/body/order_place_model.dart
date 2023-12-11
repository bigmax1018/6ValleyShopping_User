
class OrderPlaceModel {

  String? _paymentMethod;
  double? _discount;

  OrderPlaceModel(

      String paymentMethod,
      double? discount) {
    _paymentMethod = paymentMethod;
    _discount = discount;
  }


  String? get paymentMethod => _paymentMethod;
  double? get discount => _discount;

  OrderPlaceModel.fromJson(Map<String, dynamic> json) {

    _paymentMethod = json['payment_method'];
    _discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};


    data['payment_method'] = _paymentMethod;
    data['discount'] = _discount;
    return data;
  }
}

