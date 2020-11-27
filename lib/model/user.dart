import 'package:json_annotation/json_annotation.dart';
import 'package:suyu_simple/model/friend.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String username;
  String faceImage;
  String faceImageBig;
  String nickname;
  String qrcode;
  String token;
  Friend friend;

  User(
      {this.id,
      this.username,
      this.faceImage,
      this.faceImageBig,
      this.nickname,
      this.qrcode,
      this.friend,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
