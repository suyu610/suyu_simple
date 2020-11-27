class StrUtil {
  static bool isNumber(String val) {
    if (val == null) {
      return false;
    }
    RegExp reg = new RegExp(r"^[0-9]*$");
    print(reg.hasMatch(val));
    return reg.hasMatch(val);
  }
}
