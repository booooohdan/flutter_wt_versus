import 'package:flutter/material.dart';

class ComparisonProvider with ChangeNotifier {
  int _indexController1 = 0;
  int _indexController2 = 0;
  int _indexController3 = 0;
  int _indexController4 = 0;

  int get indexController1 => _indexController1;

  int get indexController2 => _indexController2;

  int get indexController3 => _indexController3;

  int get indexController4 => _indexController4;

  void setInt1Value(int intValueParam) {
    _indexController1 = intValueParam;
    notifyListeners();
  }

  void setInt2Value(int intValueParam) {
    _indexController2 = intValueParam;
    notifyListeners();
  }

  void setInt3Value(int intValueParam) {
    _indexController3 = intValueParam;
    notifyListeners();
  }

  void setInt4Value(int intValueParam) {
    _indexController4 = intValueParam;
    notifyListeners();
  }
}
