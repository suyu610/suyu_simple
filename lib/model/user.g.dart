// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    username: json['username'] as String,
    faceImage: json['faceImage'] as String,
    faceImageBig: json['faceImageBig'] as String,
    nickname: json['nickname'] as String,
    qrcode: json['qrcode'] as String,
    friend: json['friend'] == null
        ? null
        : Friend.fromJson(json['friend'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'faceImage': instance.faceImage,
      'faceImageBig': instance.faceImageBig,
      'nickname': instance.nickname,
      'qrcode': instance.qrcode,
      'token': instance.token,
      'friend': instance.friend,
    };
