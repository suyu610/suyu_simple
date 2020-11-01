import 'package:suyu_simple/model/MarkItemModel.dart';

class DailyRecorderModel {
  List<MarkItemModel> list;
  DateTime modifyDate;
  bool isSubmit; //是否已经提交
  bool isUpdate;
  int goodScore; //优秀的分数线
  int badScore; //不及格的分数线
  int totalScore;

  DailyRecorderModel(this.list, this.modifyDate, this.isUpdate, this.isSubmit,
      this.goodScore, this.badScore) {
    totalScore = 0;
    list.forEach((element) {
      this.totalScore += element.maxScore;
    });
  }

  @override
  String toString() {
    String result = "";
    list.forEach((element) {
      result += element.toString();
      result += "------------------\n";
    });

    result += badScore.toString() +
        "\n" +
        goodScore.toString() +
        "\n" +
        modifyDate.toIso8601String() +
        "\n" +
        isUpdate.toString() +
        '\n' +
        isSubmit.toString();
    return result;
  }
}
