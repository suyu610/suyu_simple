// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuyuUserVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuyuUserVO _$SuyuUserVOFromJson(Map<String, dynamic> json) {
  return SuyuUserVO(
    id: json['id'] as String,
    username: json['username'] as String,
    faceImage: json['faceImage'] as String,
    faceImageBig: json['faceImageBig'] as String,
    nickname: json['nickname'] as String,
    qrcode: json['qrcode'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$SuyuUserVOToJson(SuyuUserVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'faceImage': instance.faceImage,
      'faceImageBig': instance.faceImageBig,
      'nickname': instance.nickname,
      'qrcode': instance.qrcode,
      'token': instance.token,
    };
