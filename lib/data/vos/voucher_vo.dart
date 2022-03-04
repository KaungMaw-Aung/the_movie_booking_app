import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';

part 'voucher_vo.g.dart';

@JsonSerializable()
class VoucherVO {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "booking_no")
  String? bookingNo;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: "row")
  String? row;

  @JsonKey(name: "seat")
  String? seat;

  @JsonKey(name: "total_seat")
  int? totalSeat;

  @JsonKey(name: "total")
  String? total;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "cinema_id")
  int? cinemaId;

  @JsonKey(name: "username")
  String? username;

  @JsonKey(name: "timeslot")
  TimeslotVO? timeslot;

  @JsonKey(name: "snacks")
  List<SnackVO>? snacks;

  @JsonKey(name: "qr_code")
  String? qrCode;

  VoucherVO(
    this.id,
    this.bookingNo,
    this.bookingDate,
    this.row,
    this.seat,
    this.totalSeat,
    this.total,
    this.movieId,
    this.cinemaId,
    this.username,
    this.timeslot,
    this.snacks,
    this.qrCode,
  );

  factory VoucherVO.fromJson(Map<String, dynamic> json) =>
      _$VoucherVOFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherVOToJson(this);

  @override
  String toString() {
    return 'VoucherVO{id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieId: $movieId, cinemaId: $cinemaId, username: $username, timeslot: $timeslot, snacks: $snacks, qrCode: $qrCode}';
  }
}
