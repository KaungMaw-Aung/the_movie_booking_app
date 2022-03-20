import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'payment_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PAYMENT_VO, adapterName: "PaymentVOAdapter")
class PaymentVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "description")
  @HiveField(2)
  String? description;

  bool isSelected;

  PaymentVO(this.id, this.name, this.description, {this.isSelected = false});

  factory PaymentVO.fromJson(Map<String, dynamic> json) => _$PaymentVOFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ description.hashCode ^ isSelected.hashCode;
}