// 只有当status为200时，才是正常的

class ResultData {
  dynamic data;
  String msg;
  int status;
  ResultData({this.data, this.msg, this.status});

  @override
  String toString() {
    return "Data为${this.data.toString()}\nMsg为${this.msg.toString()}\nStatus为${this.status.toString()}\n";
  }
}
