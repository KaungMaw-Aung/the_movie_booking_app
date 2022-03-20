import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';

class TicketBloc extends ChangeNotifier {

  /// States
  VoucherVO? voucher;
  String moviePosterUrl;
  String movieTitle;
  String cinema;

  TicketBloc({
    required this.voucher,
    required this.moviePosterUrl,
    required this.movieTitle,
    required this.cinema,
  }) {
    notifyListeners();
  }

}