import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme;

  ThemeProvider(this._currentTheme);

  ThemeData getTheme() => _currentTheme;

  void changeTheme(ThemeData themeData) {
    _currentTheme = themeData;
    notifyListeners();
  }
}
