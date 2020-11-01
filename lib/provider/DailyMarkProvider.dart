// import 'package:flutter/foundation.dart';
import 'package:suyu_simple/data/SampleDate.dart';
import 'package:suyu_simple/model/DailyRecorderModel.dart';

class DailyMarkProvider {
  // with ChangeNotifier {
  DailyRecorderModel todayRecorder = SampleDate.todayRecorder;
  void increment(index) {
    // print(todayRecorder.list.getRange(index, index + 1).title);
    // notifyListeners();
  }
}

main(List<String> args) {
  DailyMarkProvider dailyMarkProvider = new DailyMarkProvider();
  dailyMarkProvider.increment(1);
}
