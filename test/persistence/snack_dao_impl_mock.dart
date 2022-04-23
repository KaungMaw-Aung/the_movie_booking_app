import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_dao.dart';

import '../mock_data/mock_data.dart';

class SnackDaoImplMock extends SnackDao {

  Map<int, SnackVO> snacksFromDatabaseMock = {};

  @override
  Stream<void> getAllEventsFromSnackBox() {
    return Stream<void>.value(null);
  }

  @override
  List<SnackVO> getAllSnacks() {
    return getMockSnacks();
  }

  @override
  Stream<List<SnackVO>> getSnacksStream() {
    return Stream.value(getAllSnacks());
  }

  @override
  void saveAllSnacks(List<SnackVO> snacks) {
    snacks.forEach((element) {
      snacksFromDatabaseMock[element.id ?? -1] = element;
    });
  }

}