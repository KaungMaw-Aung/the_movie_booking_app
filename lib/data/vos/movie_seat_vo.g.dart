// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_seat_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSeatVO _$MovieSeatVOFromJson(Map<String, dynamic> json) => MovieSeatVO(
      json['id'] as int?,
      json['type'] as String?,
      json['seat_name'] as String?,
      json['symbol'] as String?,
      json['price'] as int?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$MovieSeatVOToJson(MovieSeatVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
    };
