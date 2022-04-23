import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

abstract class SnackDao {

  void saveAllSnacks(List<SnackVO> snacks);

  List<SnackVO> getAllSnacks();

  Stream<void> getAllEventsFromSnackBox();

  Stream<List<SnackVO>> getSnacksStream();

}