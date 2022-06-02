import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

class HomeBloc extends ChangeNotifier {
  /// States
  String? name, email;
  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? comingSoonMovies;
  int selectedTabIndex = 0;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  HomeBloc([MovieBookingModel? _movieBookingModel]) {

    if (_movieBookingModel != null) {
      movieBookingModel = _movieBookingModel;
    }

    /// get user data
    movieBookingModel.getUserFromDatabase().listen((user) {
      name = user?.name ?? "";
      email = user?.email ?? "";
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    /// now playing movies
    movieBookingModel.getNowPlayingFromDatabase().listen((movies) {
      nowPlayingMovies = movies;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    /// coming soon movies
    movieBookingModel.getComingSoonFromDatabase().listen((movies) {
      comingSoonMovies = movies;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    /// prefetching snacks
    movieBookingModel.getSnacks();
  }

  Future<String?> logout() {
    return movieBookingModel.logout().then((message) {
      movieBookingModel.deleteUserFromDatabase();
      return Future.value(message);
    });
  }

  void onTapTab(int selectedIndex) {
    selectedTabIndex = selectedIndex;
    notifyListeners();
  }

}

