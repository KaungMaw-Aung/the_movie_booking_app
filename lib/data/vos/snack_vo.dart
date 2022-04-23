import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_VO, adapterName: "SnackVOAdapter")
class SnackVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  @JsonKey(name: "description")
  @HiveField(2)
  String? description;

  @JsonKey(name: "price")
  @HiveField(3)
  double? price;

  int quantity;

  SnackVO(this.id, this.name, this.description, this.price, {this.quantity = 0});

  factory SnackVO.fromJson(Map<String, dynamic> json) => _$SnackVOFromJson(json);

  Map<String, dynamic> toJson() => _$SnackVOToJson(this);


  @override
  String toString() {
    return 'SnackVO{id: $id, name: $name, description: $description, price: $price}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          price == other.price &&
          quantity == other.quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      quantity.hashCode;
}