import 'package:json_annotation/json_annotation.dart';
import 'package:suyu_simple/model/enum/MsgStatus.dart';
import 'package:suyu_simple/model/enum/MsgType.dart';
// xxx.g.dart 将在我们运行生成命令后自动生成,xxx文件名要相同

part 'ChatMessage.g.dart'; //login_info此名字需与文件名相同

/// 服务器的chat bean
/*
  private String id;
  private String sendUserId;
  private String acceptUserId;
  private String msg;
  private Integer signFlag;
  private ChatType chatType;
  private Date createTime;
*/

@JsonSerializable()
class ChatMessage {
  // 与后端id保持一致
  String msgId;
  // 消息的状态
  MsgStatus msgStatus;
  int direct;
  // 内容要不然就是文本内容，要不然就是url
  String content;
  String createID;
  String createName;
  String createTime;
  String headUrl;
  String path;
  String obj;
  MsgType type;
  String localPath;
  String hasPlayed;
  int isCrowd;
  int isDownload;
  int isPlaying;

  ChatMessage(
      {this.msgId,
      this.isSend,
      this.direct,
      this.content,
      this.createID,
      this.createName,
      this.createTime,
      this.microGroupID,
      this.headUrl,
      this.path,
      this.obj,
      this.type,
      this.hasPlayed,
      this.isCrowd,
      this.isDownload,
      this.isPlaying,
      this.localPath});

  ///注意，此LoginInfo需是类名
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
