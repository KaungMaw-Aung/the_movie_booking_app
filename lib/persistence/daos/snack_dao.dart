import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class SnackDao {

  static final SnackDao _singleton = SnackDao._internal();

  factory SnackDao() => _singleton;

  SnackDao._internal();

  void saveAllSnacks(List<SnackVO> snacks) async {
    Map<int, SnackVO> snackMap = Map.fromIterable(
        snacks, key: (snack) => snack.id, value: (snack) => snack
    );
    await getSnackBox().putAll(snackMap);
  }

  List<SnackVO> getAllSnacks() {
    return getSnackBox().values.toList();
  }

  /// reactive programming

  Stream<void> getAllEventsFromSnackBox() {
    return getSnackBox().watch();
  }

  Stream<List<SnackVO>> getSnacksStream() {
    return Stream.value(
      getAllSnacks()
    );
  }

  Box<SnackVO> getSnackBox() {
      return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }

}