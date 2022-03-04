import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';

abstract class MovieBookingModel {
  /// network
  Future<String?> registerWithEmail(
    String name,
    String email,
    String phone,
    String password,
    String? googleToken,
    String? facebookToken,
  );

  Future<String?> logout();

  Future<String?> loginWithEmail(String email, String password);

  Future<String?> loginWithGoogle(String accessToken);

  Future<String?> loginWithFacebook(String accessToken);

  void getNowPlayingMovies(int page);

  void getComingSoonMovies(int page);

  void getMovieDetail(int movieId);

  void getMovieCredit(int movieId);

  void getCinemaDayTimeslot(int movieId, String date);

  Future<List<dynamic>?> getCinemaSeatingPlan(int timeslotId, String date);

  void getSnacks();

  void getPaymentMethods();

  Future<bool> getUserCards();

  Future<String?> createCard(
    String cardNumber,
    String cardHolder,
    String expirationDate,
    String cvc,
  );

  Future<VoucherVO?> checkout(CheckoutRequest request);

  /// database
  Stream<UserVO?> getUserFromDatabase();

  void deleteUserFromDatabase();

  Stream<List<MovieVO>?> getNowPlayingFromDatabase();

  Stream<List<MovieVO>?> getComingSoonFromDatabase();

  Stream<MovieVO?> getMovieDetailByIdFromDatabase(int movieId);

  Stream<List<CastVO>> getCastsByMovieIdFromDatabase(int movieId);

  Stream<List<SnackVO>> getSnacksFromDatabase();

  Stream<List<CinemaVO>?> getCinemasFromDatabase(int movieId, String date);

  Future<List<DateVO>?> getDates();

  Stream<List<PaymentVO>> getPaymentMethodsFromDatabase();

  Stream<List<CardVO>?> getUserCardsFromDatabase();

}
