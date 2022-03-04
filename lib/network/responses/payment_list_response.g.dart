// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentListResponse _$PaymentListResponseFromJson(Map<String, dynamic> json) =>
    PaymentListResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentListResponseToJson(
        PaymentListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
