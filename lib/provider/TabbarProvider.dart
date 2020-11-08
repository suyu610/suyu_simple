import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TabbarProvider with ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;

    print(currentIndex);
    EasyLoading.dismiss();
    notifyListeners();
  }
}
