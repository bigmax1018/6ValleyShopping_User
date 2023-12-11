

class NotificationBody {
  int? orderId;
  String? type;


  NotificationBody({
    this.orderId,
    this.type,
  });

  NotificationBody.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['type'] = type;
    return data;
  }


}
