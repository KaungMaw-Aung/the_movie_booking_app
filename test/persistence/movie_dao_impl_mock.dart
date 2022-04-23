import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_dao.dart';

class MovieDaoImplMock extends MovieDao {

  Map<int, MovieVO> moviesFromDatabaseMock = {};

  @override
  Stream<void> getAllEventsFromMovieBox() {
    return Stream<void>.value(null);
  }

  @override
  List<MovieVO> getAllMovies() {
    return moviesFromDatabaseMock.values.toList();
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    return getAllMovies().where((element) => element.isComingSoon).toList();
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getComingSoonMovies());
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return moviesFromDatabaseMock[movieId];
  }

  @override
  Stream<MovieVO?> getMovieDetailsStreamById(int movieId) {
    return Stream.value(getMovieById(movieId));
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    return getAllMovies().where((element) => element.isNowPlaying).toList();
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  @override
  void saveMovieDetail(MovieVO movie) {
    moviesFromDatabaseMock[movie.id ?? -1] = movie;
  }

  @override
  void saveMovies(List<MovieVO> movies) {
    movies.forEach((element) {
      moviesFromDatabaseMock[element.id ?? -1] = element;
    });
  }

}