import 'package:flutter/material.dart';

class FirestoreProvider with ChangeNotifier {
  late int _intValue;

  int get intValue => _intValue;

  void setIntValue(int intValueParam) {
    _intValue = intValueParam;
    notifyListeners();
  }
}
