import 'package:flutter/material.dart';
import 'package:suyu_simple/net/api.dart';
import 'package:suyu_simple/viewmodels/view_state.dart';

class BaseModel extends ChangeNotifier {
  Api api;
  bool disposed = false;

  BaseModel({Api api}) : api = api;

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void dispose() {
    super.dispose();
    disposed = true;
  }

  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
}
