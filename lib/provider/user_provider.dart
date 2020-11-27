import 'package:flutter/foundation.dart';
import 'package:suyu_simple/model/user.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';

class UserProvider with ChangeNotifier {
  User _user;
  String _token;

  User getUser() {
    print(_user);
    return _user;
  }

  void init() {
    // 从本地读
    SharePreferencesUtils.user(SharePreferencesUtilsWorkType.get).then((value) {
      if (value != null) {
        _user = User.fromJson(value);
        setToken(_user.token);
        return _user;
      }
    });
  }

  String readToken() {
    return _token;
  }

  void setToken(String token) {
    _token = token;
  }

  void setUser(User user) {
    _user = user;
  }
}
