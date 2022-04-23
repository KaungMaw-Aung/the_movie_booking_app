import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

import 'genre_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {
  @JsonKey(name: "adult")
  @HiveField(0)
  bool? adult;

  @JsonKey(name: "backdrop_path")
  @HiveField(1)
  String? backdropPath;

  @JsonKey(name: "genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name: "id")
  @HiveField(3)
  int? id;

  @JsonKey(name: "original_language")
  @HiveField(4)
  String? originalLanguage;

  @JsonKey(name: "original_title")
  @HiveField(5)
  String? originalTitle;

  @JsonKey(name: "overview")
  @HiveField(6)
  String? overview;

  @JsonKey(name: "popularity")
  @HiveField(7)
  double? popularity;

  @JsonKey(name: "poster_path")
  @HiveField(8)
  String? posterPath;

  @JsonKey(name: "release_date")
  @HiveField(9)
  String? releaseDate;

  @JsonKey(name: "title")
  @HiveField(10)
  String? title;

  @JsonKey(name: "video")
  @HiveField(11)
  bool? video;

  @JsonKey(name: "vote_average")
  @HiveField(12)
  double? voteAverage;

  @JsonKey(name: "vote_count")
  @HiveField(13)
  int? voteCount;

  @JsonKey(name: "genres")
  @HiveField(14)
  List<GenreVO>? genres;

  @JsonKey(name: "runtime")
  @HiveField(15)
  int? runtime;

  @HiveField(16)
  bool isNowPlaying;

  @HiveField(17)
  bool isComingSoon;

  MovieVO(
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.genres,
    this.runtime, {
    this.isNowPlaying = false,
    this.isComingSoon = false,
  });

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVOToJson(this);

  String? getDuration() {
    if (runtime != null) {
      var duration = runtime ?? 0;
      var hour = duration ~/ 60;
      var minute = duration % 60;
      return "${hour}h ${minute}m";
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backdropPath: $backdropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount, genres: ${genres?.length ?? 0}, runtime: $runtime, isNowPlaying: $isNowPlaying, isComingSoon: $isComingSoon}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVO &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          backdropPath == other.backdropPath &&
          const ListEquality().equals(genreIds, other.genreIds) &&
          id == other.id &&
          originalLanguage == other.originalLanguage &&
          originalTitle == other.originalTitle &&
          overview == other.overview &&
          popularity == other.popularity &&
          posterPath == other.posterPath &&
          releaseDate == other.releaseDate &&
          title == other.title &&
          video == other.video &&
          voteAverage == other.voteAverage &&
          voteCount == other.voteCount &&
          const ListEquality().equals(genres, other.genres) &&
          runtime == other.runtime &&
          isNowPlaying == other.isNowPlaying &&
          isComingSoon == other.isComingSoon;

  @override
  int get hashCode =>
      adult.hashCode ^
      backdropPath.hashCode ^
      genreIds.hashCode ^
      id.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      title.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode ^
      genres.hashCode ^
      runtime.hashCode ^
      isNowPlaying.hashCode ^
      isComingSoon.hashCode;
}
