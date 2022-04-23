import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/user_dao.dart';

import '../mock_data/mock_data.dart';

class UserDaoImplMock extends UserDao {

  Map<int, UserVO> userFromDatabaseMock = {};

  @override
  void deleteUser() {
    userFromDatabaseMock.remove(0);
  }

  @override
  Stream<void> getAllEventsFromUserBox() {
    return Stream<void>.value(null);
  }

  @override
  UserVO? getUser() {
    return getMockUser();
  }

  @override
  List<CardVO>? getUserCards() {
    return getUser()?.cards;
  }

  @override
  Stream<List<CardVO>?> getUserCardsStream() {
    return Stream.value(getUserCards());
  }

  @override
  Stream<UserVO?> getUserStream() {
    return Stream.value(getUser());
  }

  @override
  void saveUser(UserVO user) {
    userFromDatabaseMock[user.id] = user;
  }

}