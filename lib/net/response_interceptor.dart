import 'package:dio/dio.dart';
import 'package:suyu_simple/model/result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    // RequestOptions option = response.request;
    try {
      //response.statusCode为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        //   ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
        int status = response.data["status"];
        String msg = response.data["msg"];
        dynamic data = response.data["data"];

        return new ResultData(status: status, msg: msg, data: data);
      }
    } catch (e) {
      print(e);
      print(e.toString() + response.request.path);
      return new ResultData(
          data: null, status: -1, msg: response.statusMessage);
    }
    return new ResultData(data: null, status: -1, msg: response.statusMessage);
  }
}
