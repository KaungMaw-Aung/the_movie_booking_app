import 'package:the_movie_booking_app/data/vos/movie_vo.dart';

abstract class MovieDao {

  void saveMovies(List<MovieVO> movies);

  List<MovieVO> getAllMovies();

  void saveMovieDetail(MovieVO movie);

  MovieVO? getMovieById(int movieId);

  List<MovieVO> getNowPlayingMovies();

  List<MovieVO> getComingSoonMovies();

  Stream<void> getAllEventsFromMovieBox();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  Stream<List<MovieVO>> getComingSoonMoviesStream();

  Stream<MovieVO?> getMovieDetailsStreamById(int movieId);

}