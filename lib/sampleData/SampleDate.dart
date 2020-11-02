import 'package:suyu_simple/model/DailyRecorderModel.dart';
import 'package:suyu_simple/model/MarkItemModel.dart';

class SampleDate {
  static DailyRecorderModel todayRecorder = new DailyRecorderModel([
    MarkItemModel("准时", "按时打卡上班", 40, 25),
    MarkItemModel("嘴甜", "嘴甜不甜", 20, 20),
    MarkItemModel("锻炼", "今天锻炼了吗", 20, 20),
    MarkItemModel("听话", "听不听我的话", 20, 20),
    MarkItemModel("听话2", "听不听我的话", 20, 20),
  ], DateTime.now(), true, true, 90, 80);
}

main() {
  print(SampleDate.todayRecorder.toString());
}
