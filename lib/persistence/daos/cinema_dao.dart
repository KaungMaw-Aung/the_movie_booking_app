import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class CinemaDao {
  static final CinemaDao _singleton = CinemaDao._internal();

  factory CinemaDao() => _singleton;

  CinemaDao._internal();

  void saveCinemas(List<CinemaVO> cinemaList, String date) async {
    List<CinemaVO> updatedCinemaList = cinemaList.map((cinema) {
      CinemaVO? cinemaFromHive = getCinemaById(cinema.cinemaId ?? -1);
      if (cinemaFromHive == null) {
        cinema.dates = [date];
        return cinema;
      } else {
        if (cinemaFromHive.dates?.contains(date) == false) {
          cinemaFromHive.dates?.add(date);
        }
        return cinemaFromHive;
      }
    }).toList();

    updatedCinemaList.forEach((element) {
      print(element.toString());
    });

    Map<int, CinemaVO> cinemaMap = Map.fromIterable(updatedCinemaList,
        key: (cinema) => cinema.cinemaId, value: (cinema) => cinema);
    await getCinemaBox().putAll(cinemaMap);
  }

  CinemaVO? getCinemaById(int cinemaId) {
    return getCinemaBox().get(cinemaId);
  }

  List<CinemaVO> getCinemaByDate(String date) {
    return getCinemaBox()
        .values
        .where((cinema) => cinema.dates?.contains(date) == true)
        .toList();
  }

  // void saveCinemasByDate(String date, List<CinemaVO> cinemas) async {
  //   await getCinemaBox().put(date, CinemaListForHiveVO(cinemas));
  // }
  //
  // List<CinemaVO>? getCinemasByDate(String date) {
  //   return getCinemaBox().get(date)?.cinemas;
  // }

  /// reactive programming
  Stream<void> getAllEventsFromCinemaBox() {
    return getCinemaBox().watch();
  }

  Stream<List<CinemaVO>> getCinemasStreamByDate(String date) {
    return Stream.value(getCinemaByDate(date));
  }

  Box<CinemaVO> getCinemaBox() {
    return Hive.box<CinemaVO>(BOX_NAME_CINEMA_VO);
  }
}
