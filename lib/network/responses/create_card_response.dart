import 'package:json_annotation/json_annotation.dart';

part 'create_card_response.g.dart';

@JsonSerializable()
class CreateCardResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  CreateCardResponse(this.code, this.message);

  factory CreateCardResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCardResponseToJson(this);

}