// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    msgId: json['msgId'] as int,
    isSend: json['isSend'] as int,
    direct: json['direct'] as int,
    content: json['content'] as String,
    createID: json['createID'] as String,
    createName: json['createName'] as String,
    createTime: json['createTime'] as String,
    microGroupID: json['microGroupID'] as String,
    headUrl: json['headUrl'] as String,
    path: json['path'] as String,
    obj: json['obj'] as String,
    type: json['type'] as int,
    hasPlayed: json['hasPlayed'] as String,
    isCrowd: json['isCrowd'] as int,
    isDownload: json['isDownload'] as int,
    isPlaying: json['isPlaying'] as int,
    localPath: json['localPath'] as String,
  );
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'msgId': instance.msgId,
      'isSend': instance.isSend,
      'direct': instance.direct,
      'content': instance.content,
      'createID': instance.createID,
      'createName': instance.createName,
      'createTime': instance.createTime,
      'headUrl': instance.headUrl,
      'microGroupID': instance.microGroupID,
      'path': instance.path,
      'obj': instance.obj,
      'type': instance.type,
      'localPath': instance.localPath,
      'hasPlayed': instance.hasPlayed,
      'isCrowd': instance.isCrowd,
      'isDownload': instance.isDownload,
      'isPlaying': instance.isPlaying,
    };
