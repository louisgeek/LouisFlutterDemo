import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart'; //声明包含子文件

@JsonSerializable()
class UserInfo {
  final String nickname;

  UserInfo({required this.nickname});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
