import 'package:json_annotation/json_annotation.dart';

part 'FriendVO.g.dart';

@JsonSerializable()
class FriendVO {
  String friendUserId;
  String friendUsername;
  String friendFaceImage;
  String friendNickname;
  FriendVO({
    this.friendUserId,
    this.friendUsername,
    this.friendFaceImage,
    this.friendNickname,
  });
  factory FriendVO.fromJson(Map<String, dynamic> json) =>
      _$FriendVOFromJson(json);

  Map<String, dynamic> toJson() => _$FriendVOToJson(this);
}
