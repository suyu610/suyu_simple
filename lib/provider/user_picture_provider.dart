import 'package:flutter/foundation.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';

class UserPictureProvider with ChangeNotifier {
  String signSvgStr = "";

  Future<void> saveSvg(String svg) async {
    signSvgStr = svg;
    await SharePreferencesUtils.sign(SharePreferencesUtilsWorkType.save,
        value: svg);
  }

  String readSvgStr() {
    return signSvgStr;
  }
}
