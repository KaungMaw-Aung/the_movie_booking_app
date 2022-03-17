import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/utils/constants.dart';

class MovieSeatsBloc extends ChangeNotifier {
  /// States
  MovieSeatVO? selectedSeat;
  List<MovieSeatVO>? movieSeats;
  int? countInARow;
  List<String> selectedSeats = [];
  double totalPrice = 0;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  MovieSeatsBloc(int timeslotId, String date) {
    /// get seats and seat count in a row
    movieBookingModel.getCinemaSeatingPlan(timeslotId, date).then((value) {
      movieSeats = value?[0] as List<MovieSeatVO>;
      countInARow = value?[1] as int;
      notifyListeners();
    }).catchError((error) => debugPrint(error.toString()));
  }

  void onTapMovieSeat(MovieSeatVO? selectedSeat) {
    if (selectedSeat?.type == SEAT_TYPE_AVAILABLE) {
      /// for unselecting seat
      if (this.selectedSeat == selectedSeat) {
        this.selectedSeat = null;
      } else {
        this.selectedSeat = selectedSeat;
      }

      movieSeats?.forEach((each) {
        if (each.id == selectedSeat?.id &&
            each.symbol == selectedSeat?.symbol) {
          each.isSelected = (selectedSeat?.isSelected == false) ? true : false;
        }
      });

      if (selectedSeat?.isSelected == true) {
        selectedSeats.add(selectedSeat?.seatName ?? "");
        totalPrice += selectedSeat?.price ?? 0;
      } else {
        selectedSeats.remove(selectedSeat?.seatName ?? "");
        totalPrice -= selectedSeat?.price ?? 0;
      }
      notifyListeners();
    }
  }
}
