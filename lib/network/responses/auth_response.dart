import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserVO? data;

  @JsonKey(name: "token")
  String? token;

  AuthResponse(this.code, this.message, this.data, this.token);

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

}