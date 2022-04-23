import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/cast_dao.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class CastDaoImpl extends CastDao {

  static final CastDaoImpl _singleton = CastDaoImpl._internal();

  factory CastDaoImpl() => _singleton;

  CastDaoImpl._internal();

  @override
  void saveCasts(List<CastVO> casts) async {
    Map<int, CastVO> castMap = Map.fromIterable(
        casts, key: (cast) => cast.id, value: (cast) => cast
    );
    await getCastBox().putAll(castMap);
  }

  @override
  void saveCast(CastVO cast) async{
    await getCastBox().put(cast.id, cast);
  }

  @override
  List<CastVO> getCasts() {
    return getCastBox().values.toList();
  }

  @override
  List<CastVO> getCastsByMovieId(int movieId) {
    return getCasts().where((cast) => cast.movieIds?.contains(movieId) == true).toList();
  }

  @override
  void updateCastInMovie(int castId, int movieId) {
    CastVO? updatedCast = getCastBox().get(castId)?.addMovieIdToList(movieId);
    if (updatedCast != null) {
      getCastBox().put(castId, updatedCast);
    }
  }

  /// reactive programming
  @override
  Stream<void> getAllEventsFromCastBox() {
    return getCastBox().watch();
  }

  @override
  Stream<List<CastVO>> getCastsStreamByMovieId(int movieId) {
    return Stream.value(
      getCasts().where((cast) => cast.movieIds?.contains(movieId) == true).toList()
    );
  }

  Box<CastVO> getCastBox() {
    return Hive.box<CastVO>(BOX_NAME_CAST_VO);
  }

}