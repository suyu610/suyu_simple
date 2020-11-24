// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FriendVO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendVO _$FriendVOFromJson(Map<String, dynamic> json) {
  return FriendVO(
    friendUserId: json['friendUserId'] as String,
    friendUsername: json['friendUsername'] as String,
    friendFaceImage: json['friendFaceImage'] as String,
    friendNickname: json['friendNickname'] as String,
  );
}

Map<String, dynamic> _$FriendVOToJson(FriendVO instance) => <String, dynamic>{
      'friendUserId': instance.friendUserId,
      'friendUsername': instance.friendUsername,
      'friendFaceImage': instance.friendFaceImage,
      'friendNickname': instance.friendNickname,
    };
