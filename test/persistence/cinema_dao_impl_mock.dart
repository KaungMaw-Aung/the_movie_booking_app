import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_dao.dart';

import '../mock_data/mock_data.dart';

class CinemaDaoImplMock extends CinemaDao {

  Map<int, CinemaVO> cinemasFromDatabaseMock = {};

  @override
  Stream<void> getAllEventsFromCinemaBox() {
    return Stream<void>.value(null);
  }

  @override
  List<CinemaVO> getCinemaByDate(String date) {
    return getMockCinemas().where((element) => element.dates?.contains(date) ?? false).toList();
  }

  @override
  CinemaVO? getCinemaById(int cinemaId) {
    return cinemasFromDatabaseMock[cinemaId];
  }

  @override
  Stream<List<CinemaVO>> getCinemasStreamByDate(String date) {
    return Stream.value(getCinemaByDate(date));
  }

  @override
  void saveCinemas(List<CinemaVO> cinemaList, String date) {
    cinemaList.forEach((element) {
      cinemasFromDatabaseMock[element.cinemaId ?? -1] = element;
    });
  }


}