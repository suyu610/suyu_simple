import 'package:flutter/cupertino.dart';
import 'package:suyu_simple/service/couter_service.dart';

// 需要后台运行的服务
void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();

  CounterService.instance().startCounting();
}
