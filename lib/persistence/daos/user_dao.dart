import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

import '../persistence_constants.dart';

class UserDao {

  static final UserDao _singleton = UserDao._internal();

  factory UserDao() => _singleton;

  UserDao._internal();

  void saveUser(UserVO user) async{
    await getUserBox().put(user.id, user);
  }

  void deleteUser() async{
    await getUserBox().deleteAt(0);
  }

  UserVO? getUser() {
    return (getUserBox().values.isNotEmpty) ? getUserBox().getAt(0) : null;
  }

  List<CardVO>? getUserCards() {
    return getUser()?.cards;
  }

  /// reactive programming

  Stream<void> getAllEventsFromUserBox() {
    return getUserBox().watch();
  }

  Stream<UserVO?> getUserStream() {
    return Stream.value(getUser());
  }

  Stream<List<CardVO>?> getUserCardsStream() {
    return Stream.value(getUserCards());
  }

  Box<UserVO> getUserBox() {
    return Hive.box<UserVO>(BOX_NAME_USER_VO);
  }

}