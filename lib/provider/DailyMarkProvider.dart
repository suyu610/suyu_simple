import 'package:flutter/foundation.dart';
import 'package:suyu_simple/data/SampleDate.dart';
import 'package:suyu_simple/model/DailyRecorderModel.dart';

class DailyMarkProvider with ChangeNotifier {
  DailyRecorderModel todayRecorder = SampleDate.todayRecorder;

  void increment(index) {
    if (todayRecorder.list.elementAt(index).currentScore <
        todayRecorder.list.elementAt(index).maxScore) {
      todayRecorder.list.elementAt(index).currentScore++;
    }
    notifyListeners();
  }

  void decrement(index) {
    if (todayRecorder.list.elementAt(index).currentScore != 0) {
      todayRecorder.list.elementAt(index).currentScore--;
    }
    notifyListeners();
  }

  void setValue(index, value) {
    print(value);
    todayRecorder.list.elementAt(index).currentScore = value;
    notifyListeners();
  }

  double totalValue() {
    double totalScore = 0;
    todayRecorder.list.forEach((element) {
      totalScore += element.currentScore;
    });
    return totalScore;
  }

  String getTitle(index) {
    return todayRecorder.list.elementAt(index).title;
  }

  int getCurrentValue(index) {
    return todayRecorder.list.elementAt(index).currentScore;
  }
}
