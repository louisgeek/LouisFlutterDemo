import 'package:json_annotation/json_annotation.dart';
import 'package:my_json_serializable/user_info.dart';

part 'user.g.dart'; //声明包含子文件

//json_annotation 的注解
//包含嵌套对象的需要设置为 true，遇到嵌套对象字段，显式调用其 toJson 方法（只影响 toJson）
@JsonSerializable(explicitToJson: true)
class User {
  final int id;
  final String name;
  @JsonKey(name: 'eee')
  final String email;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final String hulv;

  final List<String> members;
  final UserInfo userInfo;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.hulv = '忽略',
    required this.members,
    required this.userInfo,
  });

  //工厂构造函数
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
