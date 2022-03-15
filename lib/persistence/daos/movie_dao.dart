import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class MovieDao {

  static final MovieDao _singleton = MovieDao._internal();

  factory MovieDao() => _singleton;

  MovieDao._internal();

  void saveMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> moviesMap = Map.fromIterable(
        movies, key: (movie) => movie.id, value: (movie) => movie
    );
    await getMovieBox().putAll(moviesMap);
  }

  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  void saveMovieDetail(MovieVO movie) async {
    var movieFromHive = getMovieById(movie.id ?? -1);
    if (movieFromHive != null) {
      movie.isComingSoon = movieFromHive.isComingSoon;
      movie.isNowPlaying = movieFromHive.isNowPlaying;
      await getMovieBox().put(movie.id ?? -1, movie);
    }
  }

  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  List<MovieVO> getNowPlayingMovies() {
    return getAllMovies().where((movie) => movie.isNowPlaying).toList();
  }

  List<MovieVO> getComingSoonMovies() {
    return getAllMovies().where((movie) => movie.isComingSoon).toList();
  }

  /// reactive programming
  Stream<void> getAllEventsFromMovieBox() {
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(
      getAllMovies().where((movie) => movie.isNowPlaying).toList()
    );
  }

  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(
        getAllMovies().where((movie) => movie.isComingSoon).toList()
    );
  }

  Stream<MovieVO?> getMovieDetailsStreamById(int movieId) {
    return Stream.value(
      getMovieById(movieId)
    );
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

}