class ShippingMethodModel {
  int? id;
  int? creatorId;
  String? creatorType;
  String? title;
  double? cost;
  String? duration;
  int? status;
  String? createdAt;
  String? updatedAt;

  ShippingMethodModel(
      {this.id,
        this.creatorId,
        this.creatorType,
        this.title,
        this.cost,
        this.duration,
        this.status,
        this.createdAt,
        this.updatedAt});



  ShippingMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    creatorType = json['creator_type'];
    title = json['title'];
    cost = json['cost'].toDouble();
    duration = json['duration'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creator_id'] = creatorId;
    data['creator_type'] = creatorType;
    data['title'] = title;
    data['cost'] = cost;
    data['duration'] = duration;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
