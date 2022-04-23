import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class MovieDaoImpl extends MovieDao{

  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl() => _singleton;

  MovieDaoImpl._internal();

  @override
  void saveMovies(List<MovieVO> movies) async {
    Map<int, MovieVO> moviesMap = Map.fromIterable(
        movies, key: (movie) => movie.id, value: (movie) => movie
    );
    await getMovieBox().putAll(moviesMap);
  }

  @override
  List<MovieVO> getAllMovies() {
    return getMovieBox().values.toList();
  }

  @override
  void saveMovieDetail(MovieVO movie) async {
    var movieFromHive = getMovieById(movie.id ?? -1);
    if (movieFromHive != null) {
      movie.isComingSoon = movieFromHive.isComingSoon;
      movie.isNowPlaying = movieFromHive.isNowPlaying;
      await getMovieBox().put(movie.id ?? -1, movie);
    }
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return getMovieBox().get(movieId);
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    return getAllMovies().where((movie) => movie.isNowPlaying).toList();
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    return getAllMovies().where((movie) => movie.isComingSoon).toList();
  }

  /// reactive programming
  @override
  Stream<void> getAllEventsFromMovieBox() {
    return getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(
      getAllMovies().where((movie) => movie.isNowPlaying).toList()
    );
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(
        getAllMovies().where((movie) => movie.isComingSoon).toList()
    );
  }

  @override
  Stream<MovieVO?> getMovieDetailsStreamById(int movieId) {
    return Stream.value(
      getMovieById(movieId)
    );
  }

  Box<MovieVO> getMovieBox() {
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }

}