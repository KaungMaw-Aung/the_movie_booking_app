import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_dao.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class SnackDaoImpl extends SnackDao {

  static final SnackDaoImpl _singleton = SnackDaoImpl._internal();

  factory SnackDaoImpl() => _singleton;

  SnackDaoImpl._internal();

  void saveAllSnacks(List<SnackVO> snacks) async {
    Map<int, SnackVO> snackMap = Map.fromIterable(
        snacks, key: (snack) => snack.id, value: (snack) => snack
    );
    await getSnackBox().putAll(snackMap);
  }

  @override
  List<SnackVO> getAllSnacks() {
    return getSnackBox().values.toList();
  }

  /// reactive programming

  @override
  Stream<void> getAllEventsFromSnackBox() {
    return getSnackBox().watch();
  }

  @override
  Stream<List<SnackVO>> getSnacksStream() {
    return Stream.value(
      getAllSnacks()
    );
  }

  Box<SnackVO> getSnackBox() {
      return Hive.box<SnackVO>(BOX_NAME_SNACK_VO);
  }

}