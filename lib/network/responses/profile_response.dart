import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  UserVO? data;

  ProfileResponse(this.code, this.message, this.data);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

}