import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_req_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';

class ChooseCardBloc extends ChangeNotifier {
  /// States
  List<CardVO>? cards;
  int selectedCardIndex = 0;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  ChooseCardBloc([MovieBookingModel? _movieBookingModel]) {
    if (_movieBookingModel != null) {
      movieBookingModel = _movieBookingModel;
    }

    movieBookingModel.getUserCardsFromDatabase().listen((cards) {
      this.cards = cards;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }

  onCardChange(int cardIndex) {
    selectedCardIndex = cardIndex;
  }

  onTapCard(int cardId) {
    cards = cards?.map((card) {
      card.isSelected = (card.id == cardId);
      return card;
    }).toList() ?? [];
    notifyListeners();
  }

  Future<VoucherVO?> checkout(int cinemaDayTimeslotId,
      String row,
      String seatNumber,
      String bookingDate,
      double totalPrice,
      int movieId,
      int cardId,
      int cinemaId,
      List<SnackReqVO> snacks,) {
    return movieBookingModel.checkout(
      CheckoutRequest(
        cinemaDayTimeslotId,
        row,
        seatNumber,
        bookingDate,
        totalPrice,
        movieId,
        cardId,
        cinemaId,
        snacks,
      ),
    );
  }

  int getSelectedCardId() {
    return cards?[selectedCardIndex].id ?? -1;
  }

}
