import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';

part 'checkout_response.g.dart';

@JsonSerializable()
class CheckoutResponse {

  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "data")
  VoucherVO? data;

  CheckoutResponse(this.code, this.message, this.data);

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) => _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);

  @override
  String toString() {
    return 'CheckoutResponse{code: $code, message: $message, data: $data}';
  }
}