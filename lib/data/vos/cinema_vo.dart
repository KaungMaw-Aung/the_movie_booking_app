import 'package:collection/collection.dart';
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

  @HiveField(3)
  List<String>? dates;

  CinemaVO(this.cinemaId, this.cinema, this.timeslots, this.dates);

  factory CinemaVO.fromJson(Map<String, dynamic> json) => _$CinemaVOFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaVOToJson(this);

  @override
  String toString() {
    return 'CinemaVO{cinemaId: $cinemaId, cinema: $cinema, timeslots: $timeslots, dates: $dates}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaVO &&
          runtimeType == other.runtimeType &&
          cinemaId == other.cinemaId &&
          cinema == other.cinema &&
          const ListEquality().equals(timeslots, other.timeslots) &&
          const ListEquality().equals(dates, other.dates);

  @override
  int get hashCode =>
      cinemaId.hashCode ^ cinema.hashCode ^ timeslots.hashCode ^ dates.hashCode;
}