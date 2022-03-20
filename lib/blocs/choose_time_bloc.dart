import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:collection/collection.dart';

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
    selectedDate = dates?[indexOfDateList].date;
    selectedTimeslotId = null;

    dates = dates?.mapIndexed((index, date) {
      if (date is DateVO) {
        date.isSelected = index == indexOfDateList;
      }
      return date;
    }).toList();

    _clearTimeslotSelection();

    notifyListeners();
    _getCinemasFromDatabase(movieId, dates?[indexOfDateList].date);
  }

  void onTapTimeslot(int timeslotId, String movieTime) {
    selectedTimeslotId = timeslotId;
    this.movieTime = movieTime;

    cinemas = cinemas?.map((cinema) {
      cinema.timeslots?.forEach((element) {
        element.isSelected = element.cinemaTimeslotId == timeslotId;
        if (element.cinemaTimeslotId == timeslotId) {
          this.cinema = cinema.cinema;
          cinemaId = cinema.cinemaId;
        }
      });
      return cinema;
    }).toList();

    notifyListeners();
  }

  void _clearTimeslotSelection() {
    cinemas = cinemas?.map((cinema) {
      cinema.timeslots?.forEach((element) {
        element.isSelected = false;
      });
      return cinema;
    }).toList();
    cinema = null;
    cinemaId = null;
  }

}