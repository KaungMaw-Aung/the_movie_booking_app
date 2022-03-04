import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';

part 'cinema_timeslots_response.g.dart';

@JsonSerializable()
class CinemaTimeslotsResponse {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<CinemaVO>? data;

  CinemaTimeslotsResponse(this.code, this.message, this.data);

  factory CinemaTimeslotsResponse.fromJson(Map<String, dynamic> json) =>
      _$CinemaTimeslotsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaTimeslotsResponseToJson(this);

}
