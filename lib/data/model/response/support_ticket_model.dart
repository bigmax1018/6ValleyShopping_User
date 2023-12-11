class SupportTicketModel {
  int? _id;
  int? _customerId;
  String? _subject;
  String? _type;
  String? _priority;
  String? _description;
  String? _reply;
  String? _status;
  String? _createdAt;
  String? _updatedAt;

  SupportTicketModel(
      {int? id,
        int? customerId,
        String? subject,
        String? type,
        String? priority,
        String? description,
        String? reply,
        String? status,
        String? createdAt,
        String? updatedAt}) {
    _id = id;
    _customerId = customerId;
    _subject = subject;
    _type = type;
    _priority = priority;
    _description = description;
    _reply = reply;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  int? get id => _id;
  int? get customerId => _customerId;
  String? get subject => _subject;
  String? get type => _type;
  String? get priority => _priority;
  String? get description => _description;
  String? get reply => _reply;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  SupportTicketModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _customerId = json['customer_id'];
    _subject = json['subject'];
    _type = json['type'];
    _priority = json['priority'];
    _description = json['description'];
    _reply = json['reply'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['customer_id'] = _customerId;
    data['subject'] = _subject;
    data['type'] = _type;
    data['priority'] = _priority;
    data['description'] = _description;
    data['reply'] = _reply;
    data['status'] = _status;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;
    return data;
  }
}
