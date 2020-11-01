import 'package:flutter_test/flutter_test.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';

void main() async {
  // 请求前, 获取一下token塞进报文headers
  var token = "123123";
  // await SharePreferencesUtils.token(SharePreferencesUtilsWorkType.get);

  bool saveScuess = await SharePreferencesUtils.token(
      SharePreferencesUtilsWorkType.save,
      value: token);
  saveScuess ? print('token 保存成功') : print('token 保存失败');

  test("", () {
    expect(saveScuess, true);
  });
}
