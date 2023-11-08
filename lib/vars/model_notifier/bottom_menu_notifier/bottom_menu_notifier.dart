import 'package:flutter/material.dart';

class BottomMenuNotifier extends ChangeNotifier {
  int activeButtMenu = 0;

  setActiveButtMenu({required int val, bool upd = true}) {
    if (val != activeButtMenu) {
      activeButtMenu = val;
      if (upd) notifyListeners();
    }
  }
}
