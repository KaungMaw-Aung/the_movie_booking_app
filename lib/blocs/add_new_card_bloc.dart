import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';

class AddNewCardBloc extends ChangeNotifier {
  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  Future<String?> createCard(
    String cardNumber,
    String cardHolder,
    String expDate,
    String cvc,
  ) {
    return movieBookingModel.createCard(cardNumber, cardHolder, expDate, cvc)
    .then((message) {
      return movieBookingModel.getUserCards().then((_) {
        return Future.value(message);
      });
    });
  }

}
