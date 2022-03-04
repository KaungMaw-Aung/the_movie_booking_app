// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_timeslots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaTimeslotsResponse _$CinemaTimeslotsResponseFromJson(
        Map<String, dynamic> json) =>
    CinemaTimeslotsResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => CinemaVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CinemaTimeslotsResponseToJson(
        CinemaTimeslotsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
