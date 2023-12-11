
class MessageBody {
  int? _id;
  String? _message;

  MessageBody({int? id, String? message}) {
    _id = id;
    _message = message;
  }

  int? get id => _id;
  String? get message => _message;

  MessageBody.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['message'] = _message;
    return data;
  }
}
