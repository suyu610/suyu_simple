import 'package:json_annotation/json_annotation.dart';
// xxx.g.dart 将在我们运行生成命令后自动生成,xxx文件名要相同

part 'ChatMessage.g.dart'; //login_info此名字需与文件名相同

@JsonSerializable()
class ChatMessage {
  String id;
  int isSend;
  int direct;
  String content;
  String createID;
  String createName;
  String createTime;
  String headUrl;
  String microGroupID;
  String path;
  String obj;
  int type;
  String localPath;
  String hasPlayed;
  int isCrowd;
  int isDownload;
  int isPlaying;

  ChatMessage(
      {this.id,
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
