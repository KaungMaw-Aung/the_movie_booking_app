
import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier {

  /// States
  MovieVO? movie;
  List<CastVO>? casts;
  String? moviePosterUrl;
  // bool isBlocDisposed = false;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  MovieDetailsBloc(int movieId) {

    movieBookingModel
        .getMovieDetailByIdFromDatabase(movieId)
        .listen((movie) {
        moviePosterUrl = movie?.posterPath;
        this.movie = movie;
        notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    movieBookingModel
        .getCastsByMovieIdFromDatabase(movieId)
        .listen((casts) {
        this.casts = casts;
        notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

  }

  // void safeCallToNotifyListener(bool isBlocDispose) {
  //   if (isBlocDispose == false) {
  //     notifyListeners();
  //   }
  // }

}