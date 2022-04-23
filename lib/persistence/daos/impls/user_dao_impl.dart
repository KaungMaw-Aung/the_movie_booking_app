import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/user_dao.dart';

import '../../persistence_constants.dart';

class UserDaoImpl extends UserDao {

  static final UserDaoImpl _singleton = UserDaoImpl._internal();

  factory UserDaoImpl() => _singleton;

  UserDaoImpl._internal();

  @override
  void saveUser(UserVO user) async{
    await getUserBox().put(user.id, user);
  }

  @override
  void deleteUser() async{
    await getUserBox().deleteAt(0);
  }

  @override
  UserVO? getUser() {
    return (getUserBox().values.isNotEmpty) ? getUserBox().getAt(0) : null;
  }

  @override
  List<CardVO>? getUserCards() {
    return getUser()?.cards;
  }

  /// reactive programming

  @override
  Stream<void> getAllEventsFromUserBox() {
    return getUserBox().watch();
  }

  @override
  Stream<UserVO?> getUserStream() {
    return Stream.value(getUser());
  }

  @override
  Stream<List<CardVO>?> getUserCardsStream() {
    return Stream.value(getUserCards());
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }

}