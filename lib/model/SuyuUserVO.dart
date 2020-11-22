import 'package:json_annotation/json_annotation.dart';
part 'SuyuUserVO.g.dart';

@JsonSerializable()
class SuyuUserVO {
  String id;
  String username;
  String faceImage;
  String faceImageBig;
  String nickname;
  String qrcode;
  String token;

  SuyuUserVO(
      {this.id,
      this.username,
      this.faceImage,
      this.faceImageBig,
      this.nickname,
      this.qrcode,
      this.token});

  factory SuyuUserVO.fromJson(Map<String, dynamic> json) => _$SuyuUserVOFromJson(json);

  Map<String, dynamic> toJson() => _$SuyuUserVOToJson(this);
}
