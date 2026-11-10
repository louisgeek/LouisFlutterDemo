import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final UserDto user;
  
  LoginResponse({
    required this.token,
    required this.user,
  });
  
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserDto {
  final int id;
  final String name;
  final String email;
  
  UserDto({
    required this.id,
    required this.name,
    required this.email,
  });
  
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}