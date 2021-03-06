import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'card_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CARD_VO, adapterName: "CardVOAdapter")
class CardVO {

  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "card_holder")
  @HiveField(1)
  String? cardHolder;

  @JsonKey(name: "card_number")
  @HiveField(2)
  String? cardNumber;

  @JsonKey(name: "expiration_date")
  @HiveField(3)
  String? expirationDate;

  @JsonKey(name: "card_type")
  @HiveField(4)
  String? cardType;

  bool isSelected = false;

  CardVO(this.id, this.cardHolder, this.cardNumber, this.expirationDate,
      this.cardType, {this.isSelected = false});

  factory CardVO.fromJson(Map<String, dynamic> json) => _$CardVOFromJson(json);

  Map<String, dynamic> toJson() => _$CardVOToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          cardHolder == other.cardHolder &&
          cardNumber == other.cardNumber &&
          expirationDate == other.expirationDate &&
          cardType == other.cardType &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      id.hashCode ^
      cardHolder.hashCode ^
      cardNumber.hashCode ^
      expirationDate.hashCode ^
      cardType.hashCode ^
      isSelected.hashCode;

  @override
  String toString() {
    return 'CardVO{id: $id, cardHolder: $cardHolder, cardNumber: $cardNumber, expirationDate: $expirationDate, cardType: $cardType, isSelected: $isSelected}';
  }
}