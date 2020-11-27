import 'package:flutter/foundation.dart';

class FontFamilyProvider with ChangeNotifier {
  bool isUseCustomFontFamily = false;
  String get fontFamily => isUseCustomFontFamily ? "kaitiFont" : "myFont";

  void changeFont() {
    isUseCustomFontFamily = !isUseCustomFontFamily;
    notifyListeners();
  }
}
