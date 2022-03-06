class ResponseModel {
  bool _isSuccess;
  String _message;

  ResponseModel(this._message, this._isSuccess);

  String get message => _message;
  bool get isSuccess => _isSuccess;
}
