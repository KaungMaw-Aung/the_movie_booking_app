import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/data_agents/movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';

import '../mock_data/mock_data.dart';

class MovieBookingDataAgentImplMock extends MovieBookingDataAgent {

  @override
  Future<VoucherVO?> checkout(String token, CheckoutRequest request) {
    return Future.value(getMockVoucher());
  }

  @override
  Future<String?> createCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return Future.value(createNewCardSucceedMessage());
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(String token, int movieId, String date) {
    return Future.value(getMockCinemas());
  }

  @override
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(String token, int timeslotId, String bookingDate) {
    return Future.value(getMockMovieSeats());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return Future.value(
      getMockMovies().where((element) => element.isComingSoon).toList()
    );
  }

  @override
  Future<List<CastVO>?> getMovieCredit(int movieId) {
    return Future.value(
      (movieId == 508947) ? [getMockCasts().first] : [getMockCasts().last]
    );
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return Future.value(getMockMovie());
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return Future.value(
        getMockMovies().where((element) => element.isNowPlaying).toList()
    );
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethods(String token) {
    return Future.value(getMockPayments());
  }

  @override
  Future<List<SnackVO>?> getSnacks(String token) {
    return Future.value(getMockSnacks());
  }

  @override
  Future<List<CardVO>?> getUserCards(String token) {
    return Future.value(getMockCards());
  }

  @override
  Future<List> loginWithEmail(String email, String password) {
    return Future.value(
      [
        getMockUser(),
        getMockUser().token,
        "Login Succeed"
      ]
    );
  }

  @override
  Future<List> loginWithFacebook(String accessToken) {
    return Future.value(
        [
          getMockUser(),
          getMockUser().token,
          "Login Succeed"
        ]
    );
  }

  @override
  Future<List> loginWithGoogle(String accessToken) {
    return Future.value(
        [
          getMockUser(),
          getMockUser().token,
          "Login Succeed"
        ]
    );
  }

  @override
  Future<String?> logout(String token) {
    return Future.value(getLogOutSucceedMessage());
  }

  @override
  Future<List> registerWithEmail(String name, String email, String phone, String password, String? googleAccessToken, String? facebookAccessToken) {
    return Future.value(
        [
          getMockUser(),
          getMockUser().token,
          "Register Succeed"
        ]
    );
  }


}