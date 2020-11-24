import 'package:suyu_simple/model/DailyRecorderModel.dart';
import 'package:suyu_simple/model/MarkItemModel.dart';

class SampleDate {
  static DailyRecorderModel todayRecorder = new DailyRecorderModel([
    MarkItemModel("准时", "按时打卡上班", 40, 25),
    MarkItemModel("嘴甜", "嘴甜不甜", 20, 20),
    MarkItemModel("锻炼", "今天锻炼了吗", 20, 20),
    MarkItemModel("听话", "听不听我的话", 20, 20),
  ], DateTime.now(), true, true, 90, 80);
  static List<String> CardList = [
    "亲亲卡",
    "抱抱卡",
    "看电影卡",
    "看电影卡2",
    "看电影卡3",
    "看电影卡4",
    "看电影卡5",
    "看电影卡6",
    "看电影卡7",
    "看电影卡8",
    "看电影卡9",
    "看电影卡0",
    "看电影卡11"
  ];
}

main() {
  print(SampleDate.todayRecorder.toString());
}
