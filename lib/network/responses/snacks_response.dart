import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

part 'snacks_response.g.dart';

@JsonSerializable()
class SnacksResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<SnackVO>? data;

  SnacksResponse(this.code, this.message, this.data);

  factory SnacksResponse.fromJson(Map<String, dynamic> json) =>
      _$SnacksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SnacksResponseToJson(this);

}