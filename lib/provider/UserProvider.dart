import 'package:flutter/foundation.dart';
import 'package:suyu_simple/model/SuyuUserVO.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';

class UserProvider with ChangeNotifier {
  SuyuUserVO _suyuUserVO;
  String _token;

  SuyuUserVO getUser() {
    return _suyuUserVO;
  }

  void init() {
    // 从本地读
    SharePreferencesUtils.suyuUserVo(SharePreferencesUtilsWorkType.get)
        .then((value) {
      _suyuUserVO = SuyuUserVO.fromJson(value);
      setToken(_suyuUserVO.token);
      return _suyuUserVO;
    });
  }

  String readToken() {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  void setToken(String token) {
    _token = token;
  }

  void setUserVO(SuyuUserVO suyuUserVO) {
    _suyuUserVO = suyuUserVO;
  }
}
