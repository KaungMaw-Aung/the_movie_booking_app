import 'package:the_movie_booking_app/data/vos/cast_vo.dart';

abstract class CastDao {

  void saveCasts(List<CastVO> casts);

  void saveCast(CastVO cast);

  List<CastVO> getCasts();

  List<CastVO> getCastsByMovieId(int movieId);

  void updateCastInMovie(int castId, int movieId);

  Stream<void> getAllEventsFromCastBox();

  Stream<List<CastVO>> getCastsStreamByMovieId(int movieId);

}