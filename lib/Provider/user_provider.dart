import 'package:flutter/material.dart';
import '../Models/Users.dart';
import '../Resources/auth_methods.dart';



class UserProvider with ChangeNotifier {

  late User _user;
  final AuthMethods _authMethods = AuthMethods(); // instance of authmethods to get to its methods

  User get getUser => _user;
  String get getRoomNo => _user.roomNo;
  String get getUid => _user.uid;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }


}