import 'package:flutter/material.dart';

class SenseChangeProvider with ChangeNotifier{

  bool _sensechange = true;

  bool get getsensechange => _sensechange;

  void setSenseChange(){
    _sensechange = !_sensechange;
    notifyListeners();
  }

}