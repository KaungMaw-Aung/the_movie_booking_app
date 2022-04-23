import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';

abstract class UserDao {

  void saveUser(UserVO user);

  void deleteUser();

  UserVO? getUser();

  List<CardVO>? getUserCards();

  Stream<void> getAllEventsFromUserBox();

  Stream<UserVO?> getUserStream();

  Stream<List<CardVO>?> getUserCardsStream();

}