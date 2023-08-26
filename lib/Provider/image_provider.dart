import 'dart:io';

import 'package:flutter/material.dart';

class MyImageProvider with ChangeNotifier {
 // instance of authmethods to get to its methods

  String? file;

  String? get getImage => file;

  Future<void> setImage(String setfile) async {
    file = setfile;
    notifyListeners();
  }


}