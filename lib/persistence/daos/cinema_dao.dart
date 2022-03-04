import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class CinemaDao {
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao() => _singleton;

  CinemaDao._internal();

  void saveCinemasByDate(String date, List<CinemaVO> cinemas) async {
    await getCinemaBox().put(date, CinemaListForHiveVO(cinemas));
  }

  List<CinemaVO>? getCinemasByDate(String date) {
    return getCinemaBox().get(date)?.cinemas;
  }

  /// reactive programming
  Stream<void> getAllEventsFromCinemaBox() {
    return getCinemaBox().watch();
  }

  Stream<List<CinemaVO>?> getCinemasStreamByDate(String date) {
    return Stream.value(
      getCinemaBox().get(date)?.cinemas
    );
  }

  Box<CinemaListForHiveVO> getCinemaBox() {
    return Hive.box<CinemaListForHiveVO>(BOX_NAME_CINEMA_LIST_FOR_HIVE_VO);
  }
}
