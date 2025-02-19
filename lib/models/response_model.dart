import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';

class ResponseModel{
  bool _isSuccess;
  String _message;
  ResponseModel(this._isSuccess, this._message);
  String get message => _message;
  bool get isSuccess => _isSuccess;

}