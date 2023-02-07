import 'package:flutter/material.dart';

class UiService extends ChangeNotifier {
  // 0 = geo, 1 = http
  int _selectedOpt = 0;

  int get selected {
    return _selectedOpt;
  }

  set selected(int opt) {
    _selectedOpt = opt;
    notifyListeners();
  }
}
