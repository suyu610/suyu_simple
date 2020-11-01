import 'package:suyu_simple/model/MarkItemModel.dart';

class DailyRecorderModel {
  List<MarkItemModel> list;
  DateTime modifyDate;
  bool isSubmit; //是否已经提交
  bool isUpdate;
  int goodScore; //优秀的分数线
  int badScore; //不及格的分数线

  DailyRecorderModel(this.list, this.modifyDate, this.isUpdate, this.isSubmit,
      this.goodScore, this.badScore);

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

// main() {

//   List<MarkItemModel> list = new List<MarkItemModel>();
//   list.add(markItemModel1);
//   list.add(markItemModel2);

//   DailyRecorderModel dailyRecorderModel =
//       new DailyRecorderModel(list, DateTime.now(), true, true);
//   print(dailyRecorderModel.toString());
// }
