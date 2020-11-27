// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return ChatMessage(
    msgId: json['msgId'] as String,
    direct: json['direct'] as int,
    content: json['content'] as String,
    createTime: json['createTime'] as String,
    type: _$enumDecodeNullable(_$MsgTypeEnumMap, json['type']),
    hasPlayed: json['hasPlayed'] as int,
    isDownload: json['isDownload'] as int,
    isPlaying: json['isPlaying'] as int,
    localPath: json['localPath'] as String,
  )..msgStatus = _$enumDecodeNullable(_$MsgStatusEnumMap, json['msgStatus']);
}

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'msgId': instance.msgId,
      'type': _$MsgTypeEnumMap[instance.type],
      'msgStatus': _$MsgStatusEnumMap[instance.msgStatus],
      'direct': instance.direct,
      'content': instance.content,
      'createTime': instance.createTime,
      'localPath': instance.localPath,
      'hasPlayed': instance.hasPlayed,
      'isDownload': instance.isDownload,
      'isPlaying': instance.isPlaying,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$MsgTypeEnumMap = {
  MsgType.Text: 'Text',
  MsgType.Pic: 'Pic',
  MsgType.Mic: 'Mic',
};

const _$MsgStatusEnumMap = {
  MsgStatus.isSent: 'isSent',
  MsgStatus.Sending: 'Sending',
  MsgStatus.Failed: 'Failed',
  MsgStatus.Uploading: 'Uploading',
  MsgStatus.Downloading: 'Downloading',
};
