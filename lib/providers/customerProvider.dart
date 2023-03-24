
import 'package:flutter/material.dart';

class CustomerProvider with ChangeNotifier {
  bool _isLogin = false;
  String _userId = "";
  String _phone = "099999999";
  int _point = 200;

  bool get isLogin => _isLogin;
  String get userId => _userId;
  String get phone => _phone;
  int get point => _point;

  getUserId() {
    return _userId;
  }

  void login(String userId, String phone, int point) {
    print("login: $userId, $phone, $point");

    _userId = userId;
    _phone = phone;
    _point = point;
    _isLogin = true;

    notifyListeners();
  }

  void logout() {
    print("before logout: $_userId, $_phone, $_point");
    _userId = "";
    _phone = "";
    _point = 0;
    _isLogin = false;
    notifyListeners();
  }

}
