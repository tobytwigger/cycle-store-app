import 'package:cycle_store_app/api/models.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class CurrentUser extends ChangeNotifier {
  
  User? _user;

  User? get user {
    return _user;
  }

  set user(User? user) {
    log('Setting user');
    _user = user;
    notifyListeners();
  }
  
}