
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'cast_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CAST_VO, adapterName: "CastVOAdapter")
class CastVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "profile_path")
  @HiveField(2)
  String? profilePath;

  @HiveField(3)
  List<int>? movieIds;

  CastVO(this.id, this.name, this.profilePath, this.movieIds);

  factory CastVO.fromJson(Map<String, dynamic> json) => _$CastVOFromJson(json);

  Map<String, dynamic> toJson() => _$CastVOToJson(this);

  CastVO addMovieIdToList(int movieId) {
    if (movieIds?.contains(movieId) == false) {
      movieIds?.add(movieId);
    }
    return this;
  }

  @override
  String toString() {
    return 'CastVO{id: $id, name: $name, profilePath: $profilePath, movieIds: ${movieIds?.length ?? 0}';
  }
}