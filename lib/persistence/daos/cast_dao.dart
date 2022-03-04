import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class CastDao {

  static final CastDao _singleton = CastDao._internal();

  factory CastDao() => _singleton;

  CastDao._internal();

  void saveCasts(List<CastVO> casts) async {
    Map<int, CastVO> castMap = Map.fromIterable(
        casts, key: (cast) => cast.id, value: (cast) => cast
    );
    await getCastBox().putAll(castMap);
  }

  void saveCast(CastVO cast) async{
    await getCastBox().put(cast.id, cast);
  }

  List<CastVO> getCasts() {
    return getCastBox().values.toList();
  }

  Box<CastVO> getCastBox() {
    return Hive.box<CastVO>(BOX_NAME_CAST_VO);
  }

  void updateCastInMovie(int castId, int movieId) {
    CastVO? updatedCast = getCastBox().get(castId)?.addMovieIdToList(movieId);
    if (updatedCast != null) {
      getCastBox().put(castId, updatedCast);
    }
  }


}