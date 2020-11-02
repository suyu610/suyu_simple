import 'package:sqflite/sqlite_api.dart';
import 'package:suyu_simple/db/db_provider.dart';
import 'package:suyu_simple/model/ChatMessage.dart';

class ChatDAO extends BaseDBProvider {
  //表名
  final String name = "ChatMessage";
  //表主键字段
  final String columnID = "_id";

  @override
  tableName() {
    return name;
  }

  //创建表
  @override
  tableSqlString() {
    return tableBaseString(name, columnID) +
        '''
    id text not null,
    content text,
    createID text,
    createName text,
    createTime text,
    headUrl text,
    microGroupID text,
    path text,
    obj text,
    type integer,
    localPath text,
    hasPlayed integer,
    isCrowd integer,
    isDownload integer,
    isPlaying integer,
    isSend integer not null,
    direct integer not null)
   ''';
  }

  ///
  /// 插入一条信息
  ///
  Future insert(ChatMessage msg) async {
    Database db = await getDataBase();
    return await db.insert(name, toMap(msg));
  }

  //
  // 根据ID查询数据
  //

  // 根据ID的查询所有消息
  Future<List<ChatMessage>> getMessageList() async {
    Database db = await getDataBase();
    List<Map<String, dynamic>> maps = await db.query(name);
    print("*************************");
    print(maps.length);
    print("*************************");
    if (maps.length > 0) {
      List<ChatMessage> msgs =
          maps.map((item) => ChatMessage.fromJson(item)).toList();
      return msgs;
    }
    return null;
  }

  //删除所有数据
  Future<int> deleteAllMsg() async {
    Database db = await getDataBase();
    return await db.rawDelete("delete from $name");
  }

  Map<String, dynamic> toMap(ChatMessage msg) {
    Map<String, dynamic> map = {
      "id": msg.id,
      "content": msg.content,
      "createId": msg.createID,
      "createName": msg.createName,
      "createTime": msg.createTime,
      "headUrl": msg.headUrl,
      "microGroupId": msg.microGroupID,
      "path": msg.path,
      "obj": msg.obj,
      "localPath": msg.localPath,
      "type": msg.type,
      "hasPlayed": msg.hasPlayed,
      " isCrowd": msg.isCrowd,
      " isDownload": msg.isDownload,
      "isPlaying": msg.isPlaying,
      "isSend": msg.isSend,
      "direct": msg.direct,
    };
    return map;
  }
}