
import 'package:json_annotation/json_annotation.dart';

part 'snack_req_vo.g.dart';

@JsonSerializable()
class SnackReqVO {

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "quantity")
  int? quantity;

  SnackReqVO(this.id, this.quantity);

  factory SnackReqVO.fromJson(Map<String, dynamic> json) => _$SnackReqVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnackReqVOToJson(this);

}