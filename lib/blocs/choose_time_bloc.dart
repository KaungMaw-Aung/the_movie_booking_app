import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';

class ChooseTimeBloc extends ChangeNotifier {

  final int? movieId;

  /// States
  List<DateVO>? dates;
  List<CinemaVO>? cinemas;
  int? selectedDateIndex;
  String? selectedDate;
  int? selectedTimeslotId;
  String? movieTime;
  String? cinema;
  int? cinemaId;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  ChooseTimeBloc(this.movieId) {

    /// dates
    movieBookingModel.getDates().then((dates) {
      this.dates = dates;
      selectedDate = dates?.first.date;

      notifyListeners();
      _getCinemasFromDatabase(movieId, dates?.first.date);
    });
  }

  void _getCinemasFromDatabase(int? movieId, String? date) {
    if (movieId != null && date != null) {
      movieBookingModel.getCinemasFromDatabase(movieId, date)
          .listen((cinemas) {
        this.cinemas = cinemas;
        notifyListeners();
      }).onError((error) => debugPrint(error.toString()));
    }
  }

  void onTapDate(int indexOfDateList) {
    selectedDateIndex = indexOfDateList;
    selectedDate = dates?[indexOfDateList].date;
    selectedTimeslotId = null;
    notifyListeners();
    _getCinemasFromDatabase(movieId, dates?[indexOfDateList].date);
  }

  void onTapTimeslot(int timeslotId, String movieTime) {
    selectedTimeslotId = timeslotId;
    this.movieTime = movieTime;
    cinemas?.forEach((cinema) {
      cinema.timeslots?.forEach((element) {
        if (element.cinemaTimeslotId == timeslotId) {
          this.cinema = cinema.cinema;
          cinemaId = cinema.cinemaId;
        }
      });
    });
    notifyListeners();
  }

}