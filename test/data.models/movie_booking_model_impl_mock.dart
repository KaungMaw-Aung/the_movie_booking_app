import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
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

import '../mock_data/mock_data.dart';

class MovieBookingModelImplMock extends MovieBookingModel {
  @override
  Future<VoucherVO?> checkout(CheckoutRequest request) {
    return Future.value(getMockVoucher());
  }

  @override
  Future<String?> createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(createNewCardSucceedMessage());
  }

  @override
  void deleteUserFromDatabase() {
    // No need to mock
  }

  @override
  Stream<List<CastVO>> getCastsByMovieIdFromDatabase(int movieId) {
    return Stream.value(getMockCasts()
        .where((element) => element.movieIds?.contains(movieId) ?? false)
        .toList());
  }

  @override
  void getCinemaDayTimeslot(int movieId, String date) {
    // No need to mock
  }

  @override
  Future<List?> getCinemaSeatingPlan(int timeslotId, String date) {
    return Future.value([
      getMockMovieSeats().expand((seatList) => seatList).toList(),
      getMockMovieSeats().first.length,
    ]);
  }

  @override
  Stream<List<CinemaVO>?> getCinemasFromDatabase(int movieId, String date) {
    return Stream.value(getMockCinemas()
        .where((element) => element.dates?.contains(date) ?? false)
        .toList());
  }

  @override
  Stream<List<MovieVO>?> getComingSoonFromDatabase() {
    return Stream.value(
        getMockMovies().where((element) => element.isComingSoon).toList());
  }

  @override
  void getComingSoonMovies(int page) {
    // No need to mock
  }

  @override
  Future<List<DateVO>?> getDates() {
    return Future.value(getMockDates());
  }

  @override
  void getMovieCredit(int movieId) {
    // No need to mock
  }

  @override
  void getMovieDetail(int movieId) {
    // No need to mock
  }

  @override
  Stream<MovieVO?> getMovieDetailByIdFromDatabase(int movieId) {
    return Stream.value(getMockMovie());
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingFromDatabase() {
    return Stream.value(
        getMockMovies().where((element) => element.isNowPlaying).toList());
  }

  @override
  void getNowPlayingMovies(int page) {
    // No need to mock
  }

  @override
  void getPaymentMethods() {
    // No need to mock
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodsFromDatabase() {
    return Stream.value(getMockPayments());
  }

  @override
  void getSnacks() {
    // No need to mock
  }

  @override
  Stream<List<SnackVO>> getSnacksFromDatabase() {
    return Stream.value(getMockSnacks());
  }

  @override
  Future<bool> getUserCards() {
    // No need to mock
    throw UnimplementedError();
  }

  @override
  Stream<List<CardVO>?> getUserCardsFromDatabase() {
    return Stream.value(getMockCards());
  }

  @override
  Stream<UserVO?> getUserFromDatabase() {
    return Stream.value(getMockUser());
  }

  @override
  Future<String?> loginWithEmail(String email, String password) {
    return Future.value("Login succeed");
  }

  @override
  Future<String?> loginWithFacebook(String accessToken) {
    return Future.value("Login succeed");
  }

  @override
  Future<String?> loginWithGoogle(String accessToken) {
    return Future.value("Login succeed");
  }

  @override
  Future<String?> logout() {
    return Future.value(getLogOutSucceedMessage());
  }

  @override
  Future<String?> registerWithEmail(String name, String email, String phone,
      String password, String? googleToken, String? facebookToken) {
    return Future.value("Register succeed");
  }
}
