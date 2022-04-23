import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/cast_dao.dart';

class CastDaoImplMock extends CastDao {

  Map<int,  CastVO> castsFromDatabaseMock = {};

  @override
  Stream<void> getAllEventsFromCastBox() {
    return Stream<void>.value(null);
  }

  @override
  List<CastVO> getCasts() {
    return castsFromDatabaseMock.values.toList();
  }

  @override
  List<CastVO> getCastsByMovieId(int movieId) {
    return castsFromDatabaseMock.values.where((element) => element.movieIds?.contains(movieId) ?? false).toList();
  }

  @override
  Stream<List<CastVO>> getCastsStreamByMovieId(int movieId) {
    return Stream.value(getCastsByMovieId(movieId));
  }

  @override
  void saveCast(CastVO cast) {
    castsFromDatabaseMock[cast.id ?? -1] = cast;
  }

  @override
  void saveCasts(List<CastVO> casts) {
    casts.forEach((element) {
      castsFromDatabaseMock[element.id ?? -1] = element;
    });
  }

  @override
  void updateCastInMovie(int castId, int movieId) {
    var updatedCast = castsFromDatabaseMock[castId]?.addMovieIdToList(movieId);
    if (updatedCast != null) {
      castsFromDatabaseMock[castId] = updatedCast;
    }
  }

}