
import 'package:flutter/material.dart';
import 'package:waiter_app/models/customer.dart';


class CustomerProvider with ChangeNotifier {
  bool _isLogin = false;
  Customer? _customer;

  Customer? get customer => _customer;
  bool get isLogin => _isLogin;


  void login(String userId, String phone) {
    _customer = Customer(userId: userId, phone: phone);
    _isLogin = true;
    notifyListeners();
  }

  void logout() {
    _customer = null;
    notifyListeners();
  }
}
