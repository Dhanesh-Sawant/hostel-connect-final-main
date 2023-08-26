import 'package:flutter/material.dart';
import '../Resources/auth_methods.dart';
import '../Models/Admins.dart';

class AdminProvider with ChangeNotifier {

  late Admin _admin;
  final AuthMethods _authMethods = AuthMethods(); // instance of authmethods to get to its methods

  Admin get getAdmin => _admin;

  String get getEid => _admin.eid;
  String get getBlock => _admin.block;

  Future<void> refreshAdmin() async {
    Admin admin = await _authMethods.getAdminDetails();
    _admin = admin;
    notifyListeners();
  }


}