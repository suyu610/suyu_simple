import 'dart:async';
import 'package:suyu_simple/net/api.dart';
import 'package:suyu_simple/viewmodels/base_model.dart';

class LoginViewModel extends BaseModel {
  LoginViewModel({Api api}) : super(api: api);

  Timer _timer;
  int _countdownTime = 0;

  Future<void> sendSms(String mobile) async {
    // await api.sensSms(mobile);
    return true;
  }

  Future<bool> login(String mobile, String sms) async {
    // return await api.login(mobile, sms) != null;
    return true;
  }

  void startCountdown() {
    _countdownTime = 60;
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        countdownTime--;
        if (countdownTime == 0) {
          cancelTimer();
        }
      });
    }
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void dispose() {
    cancelTimer();
    super.dispose();
  }

  int get countdownTime => _countdownTime;

  set countdownTime(int value) {
    _countdownTime = value;
    notifyListeners();
  }
}
