import 'package:json_annotation/json_annotation.dart';
import 'package:suyu_simple/constant/msg_status.dart';
import 'package:suyu_simple/constant/msg_type.dart';
// xxx.g.dart 将在我们运行生成命令后自动生成,xxx文件名要相同

part 'chat_message.g.dart'; //login_info此名字需与文件名相同

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

  MsgType type;

  // 消息的状态
  MsgStatus msgStatus;
  // 收到的消息为【1】
  // 发出去的消息为【0】
  int direct;
  // 内容是文本内容，或者是url
  String content;
  //
  String createTime;

  String localPath;

  //针对type = mic的消息，其他消息不具备此属性
  //如果没有播放，则这个属性为0
  //如果播放了，则为1
  int hasPlayed;

  int isDownload;

  int isPlaying;

  ChatMessage(
      {this.msgId,
      this.direct,
      this.content,
      this.createTime,
      this.type,
      this.hasPlayed,
      this.isDownload,
      this.isPlaying,
      this.localPath});

  ///注意，此LoginInfo需是类名
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);
}
