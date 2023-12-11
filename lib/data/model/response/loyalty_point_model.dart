class LoyaltyPointModel {
  int? _limit;
  int? _offset;
  int? _totalLoyaltyPoint;
  List<LoyaltyPointList>? _loyaltyPointList;

  LoyaltyPointModel(
      {int? limit,
        int? offset,
        int? totalLoyaltyPoint,
        List<LoyaltyPointList>? loyaltyPointList}) {
    if (limit != null) {
      _limit = limit;
    }
    if (offset != null) {
      _offset = offset;
    }
    if (totalLoyaltyPoint != null) {
      _totalLoyaltyPoint = totalLoyaltyPoint;
    }
    if (loyaltyPointList != null) {
      _loyaltyPointList = loyaltyPointList;
    }
  }

  int? get limit => _limit;
  int? get offset => _offset;
  int? get totalLoyaltyPoint => _totalLoyaltyPoint;
  List<LoyaltyPointList>? get loyaltyPointList => _loyaltyPointList;


  LoyaltyPointModel.fromJson(Map<String, dynamic> json) {
    _limit = json['limit'];
    _offset = json['offset'];
    _totalLoyaltyPoint = json['total_loyalty_point'];
    if (json['loyalty_point_list'] != null) {
      _loyaltyPointList = <LoyaltyPointList>[];
      json['loyalty_point_list'].forEach((v) {
        _loyaltyPointList!.add(LoyaltyPointList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = _limit;
    data['offset'] = _offset;
    data['total_loyalty_point'] = _totalLoyaltyPoint;
    if (_loyaltyPointList != null) {
      data['loyalty_point_list'] =
          _loyaltyPointList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoyaltyPointList {
  int? _id;
  int? _userId;
  String? _transactionId;
  int? _credit;
  int? _debit;
  int? _balance;
  String? _reference;
  String? _transactionType;
  String? _createdAt;
  String? _updatedAt;

  LoyaltyPointList(
      {int? id,
        int? userId,
        String? transactionId,
        int? credit,
        int? debit,
        int? balance,
        String? reference,
        String? transactionType,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (transactionId != null) {
      _transactionId = transactionId;
    }
    if (credit != null) {
      _credit = credit;
    }
    if (debit != null) {
      _debit = debit;
    }
    if (balance != null) {
      _balance = balance;
    }
    if (reference != null) {
      _reference = reference;
    }
    if (transactionType != null) {
      _transactionType = transactionType;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  int? get userId => _userId;
  String? get transactionId => _transactionId;
  int? get credit => _credit;
  int? get debit => _debit;
  int? get balance => _balance;
  String? get reference => _reference;
  String? get transactionType => _transactionType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;


  LoyaltyPointList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _transactionId = json['transaction_id'];
    _credit = json['credit'];
    _debit = json['debit'];
    _balance = json['balance'];
    _reference = json['reference'];
    _transactionType = json['transaction_type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['user_id'] = _userId;
    data['transaction_id'] = _transactionId;
    data['credit'] = _credit;
    data['debit'] = _debit;
    data['balance'] = _balance;
    data['reference'] = _reference;
    data['transaction_type'] = _transactionType;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
