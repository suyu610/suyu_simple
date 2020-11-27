// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) {
  return Friend(
    friendUserId: json['friendUserId'] as String,
    friendUsername: json['friendUsername'] as String,
    friendFaceImage: json['friendFaceImage'] as String,
    friendNickname: json['friendNickname'] as String,
  );
}

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'friendUserId': instance.friendUserId,
      'friendUsername': instance.friendUsername,
      'friendFaceImage': instance.friendFaceImage,
      'friendNickname': instance.friendNickname,
    };
