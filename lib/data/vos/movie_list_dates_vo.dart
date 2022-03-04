import 'package:json_annotation/json_annotation.dart';

part 'movie_list_dates_vo.g.dart';

@JsonSerializable()
class MovieListDatesVO {

  @JsonKey(name: "maximum")
  String? maximum;

  @JsonKey(name: "minimum")
  String? minimum;

  MovieListDatesVO(this.maximum, this.minimum);

  factory MovieListDatesVO.fromJson(Map<String, dynamic> json) => _$MovieListDatesVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListDatesVOToJson(this);

}