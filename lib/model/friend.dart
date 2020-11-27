import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend {
  String friendUserId;
  String friendUsername;
  String friendFaceImage;
  String friendNickname;
  Friend({
    this.friendUserId,
    this.friendUsername,
    this.friendFaceImage,
    this.friendNickname,
  });
  factory Friend.fromJson(Map<String, dynamic> json) =>
      _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
