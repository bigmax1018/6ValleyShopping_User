class ResponseModel {
  final String? _message;
  final bool _isSuccess;

  ResponseModel(this._message, this._isSuccess);

  bool get isSuccess => _isSuccess;
  String? get message => _message;
}