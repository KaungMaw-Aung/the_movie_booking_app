// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snacks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnacksResponse _$SnacksResponseFromJson(Map<String, dynamic> json) =>
    SnacksResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SnackVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SnacksResponseToJson(SnacksResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
