import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';

part 'payment_list_response.g.dart';

@JsonSerializable()
class PaymentListResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  List<PaymentVO>? data;

  PaymentListResponse(this.code, this.message, this.data);

  factory PaymentListResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentListResponseToJson(this);

}