import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

part 'user_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_USER_VO, adapterName: "UserVOAdapter")
@JsonSerializable()
class UserVO {

  @HiveField(0)
  @JsonKey(name: "id")
  int id;

  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  @HiveField(2)
  @JsonKey(name: "email")
  String? email;

  @HiveField(3)
  @JsonKey(name: "phone")
  String? phone;

  @HiveField(4)
  @JsonKey(name: "total_expense")
  int? totalExpense;

  @HiveField(5)
  @JsonKey(name: "profile_image")
  String? profileImage;

  @HiveField(6)
  @JsonKey(name: "cards")
  List<CardVO>? cards;

  @HiveField(7)
  String? token;

  UserVO(this.id, this.name, this.email, this.phone, this.totalExpense,
      this.profileImage, this.cards, this.token);

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);

  @override
  String toString() {
    return 'UserVO{id: $id, name: $name, email: $email, phone: $phone, totalExpense: $totalExpense, profileImage: $profileImage, cards: $cards, token: $token}';
  }

  String getBearerToken() {
    return "Bearer $token";
  }

}