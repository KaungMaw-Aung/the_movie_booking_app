import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';

abstract class CinemaDao {

  void saveCinemas(List<CinemaVO> cinemaList, String date);

  CinemaVO? getCinemaById(int cinemaId);

  List<CinemaVO> getCinemaByDate(String date);

  Stream<void> getAllEventsFromCinemaBox();

  Stream<List<CinemaVO>> getCinemasStreamByDate(String date);

}