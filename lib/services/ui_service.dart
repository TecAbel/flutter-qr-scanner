import 'package:flutter/material.dart';

class UiService extends ChangeNotifier {
  int _selectedOpt = 0;

  int get selected {
    return _selectedOpt;
  }

  set selected(int opt) {
    _selectedOpt = opt;
    notifyListeners();
  }
}
