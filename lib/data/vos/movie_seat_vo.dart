import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/utils/constants.dart';

part 'movie_seat_vo.g.dart';

@JsonSerializable()
class MovieSeatVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "seat_name")
  String? seatName;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "price")
  int? price;

  bool isSelected;

  MovieSeatVO(this.id, this.type, this.seatName, this.symbol, this.price,
      {this.isSelected = false});

  factory MovieSeatVO.fromJson(Map<String, dynamic> json) =>
      _$MovieSeatVOFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSeatVOToJson(this);

  bool isMovieSeatAvailable() {
    return type == SEAT_TYPE_AVAILABLE;
  }

  bool isMovieSeatTaken() {
    return type == SEAT_TYPE_TAKEN;
  }

  bool isMovieSeatRowTitle() {
    return type == SEAT_TYPE_TEXT;
  }

  @override
  String toString() {
    return 'MovieSeatVO{id: $id, type: $type, seatName: $seatName, symbol: $symbol, price: $price, isSelected: $isSelected}';
  }
}