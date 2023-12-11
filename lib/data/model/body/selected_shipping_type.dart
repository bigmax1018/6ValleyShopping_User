class SelectedShippingType {
  int? _sellerId;
  String? _selectedShippingType;

  SelectedShippingType({int? sellerId, String? selectedShippingType}) {
    if (sellerId != null) {
      _sellerId = sellerId;
    }
    if (selectedShippingType != null) {
      _selectedShippingType = selectedShippingType;
    }
  }

  int? get sellerId => _sellerId;
  String? get selectedShippingType => _selectedShippingType;

  SelectedShippingType.fromJson(Map<String, dynamic> json) {
    _sellerId = json['sellerId'];
    _selectedShippingType = json['selectedShippingType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sellerId'] = _sellerId;
    data['selectedShippingType'] = _selectedShippingType;
    return data;
  }
}
