import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO, adapterName: "CinemaVOAdapter")
class CinemaVO {

  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinema;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeslotVO>? timeslots;

  CinemaVO(this.cinemaId, this.cinema, this.timeslots);

  factory CinemaVO.fromJson(Map<String, dynamic> json) => _$CinemaVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaVOToJson(this);

}