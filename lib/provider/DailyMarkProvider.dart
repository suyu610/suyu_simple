import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:suyu_simple/sampleData/SampleDate.dart';
import 'package:suyu_simple/model/DailyRecorderModel.dart';

class DailyMarkProvider with ChangeNotifier {
  DailyRecorderModel todayRecorder = SampleDate.todayRecorder;

  void increment(index) {
    if (todayRecorder.list.elementAt(index).currentScore <
        todayRecorder.list.elementAt(index).maxScore) {
      todayRecorder.list.elementAt(index).currentScore++;
      notifyListeners();
    } else {
      EasyLoading.showToast('已经是最大值了!',
          duration: Duration(milliseconds: 500),
          toastPosition: EasyLoadingToastPosition.top);
    }
  }

  void decrement(index) {
    if (todayRecorder.list.elementAt(index).currentScore != 0) {
      todayRecorder.list.elementAt(index).currentScore--;
      notifyListeners();
    } else {
      EasyLoading.showError('还能减到负数?!');
    }
  }

  void setValue(index, value) {
    print(value);
    todayRecorder.list.elementAt(index).currentScore = value;
    notifyListeners();
  }

  int totalValue() {
    int totalScore = 0;
    todayRecorder.list.forEach((element) {
      totalScore += element.currentScore;
    });
    return totalScore;
  }

  String getLevel() {
    print(todayRecorder.totalScore);
    if (totalValue() == todayRecorder.totalScore) {
      return "~ 完美 ~";
    } else if (totalValue() >= todayRecorder.goodScore) {
      return "优秀";
    } else if (totalValue() >= todayRecorder.badScore) {
      return "一般";
    } else if (totalValue() >= todayRecorder.badScore / 2) {
      return "很差";
    } else {
      return "离谱";
    }
  }

  int getMaxValue(index) {
    return todayRecorder.list.elementAt(index).maxScore;
  }

  String getTitle(index) {
    return todayRecorder.list.elementAt(index).title;
  }

  int getCurrentValue(index) {
    return todayRecorder.list.elementAt(index).currentScore;
  }

  int getLength() {
    return todayRecorder.list.length;
  }
}
