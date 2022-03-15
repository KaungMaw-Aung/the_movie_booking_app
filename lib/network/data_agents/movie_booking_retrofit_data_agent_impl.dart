import 'package:dio/dio.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/data_agents/movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/network/movie_booking_api.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/network/tmdb_api.dart';

import '../api_constants.dart';

class MovieBookingRetrofitDataAgentImpl extends MovieBookingDataAgent {
  late MovieBookingApi mApi;
  late TmdbApi tmdbApi;

  static final MovieBookingRetrofitDataAgentImpl _singleton =
      MovieBookingRetrofitDataAgentImpl._internal();

  factory MovieBookingRetrofitDataAgentImpl() => _singleton;

  MovieBookingRetrofitDataAgentImpl._internal() {
    Dio dio = Dio();
    mApi = MovieBookingApi(dio);

    Dio tmdbDio = Dio();
    tmdbApi = TmdbApi(tmdbDio);
  }

  @override
  Future<List<dynamic>> registerWithEmail(
      String name,
      String email,
      String phone,
      String password,
      String? googleAccessToken,
      String? facebookAccessToken) {
    return mApi
        .registerWithEmail(name, email, phone, password,
            googleAccessToken ?? "", facebookAccessToken ?? "")
        .asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<String?> logout(String token) {
    return mApi
        .logout(token)
        .asStream()
        .map((response) => response.message)
        .first;
  }

  @override
  Future<List<dynamic>> loginWithEmail(String email, String password) {
    return mApi
        .loginWithEmail(email, password)
        .then((value) {
          if (value.code == RESPONSE_CODE_SUCCESS) {
            return Future.value(value);
          } else {
            return Future.error(value.message ?? "auth error");
          }
        })
        .asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<List<dynamic>> loginWithGoogle(String accessToken) {
    return mApi
        .loginWithGoogle(accessToken)
        .asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<List<dynamic>> loginWithFacebook(String accessToken) {
    return mApi
        .loginWithFacebook(accessToken)
        .asStream()
        .map((response) => [response.data, response.token, response.message])
        .first;
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return tmdbApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response?.results)
        .first;
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return tmdbApi
        .getComingSoonMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response?.results)
        .first;
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return tmdbApi.getMovieDetail(movieId.toString(), API_KEY, LANGUAGE_EN_US);
  }

  @override
  Future<List<CastVO>?> getMovieCredit(int movieId) {
    return tmdbApi
        .getMovieCredit(movieId.toString(), API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.cast)
        .first;
  }

  @override
  Future<List<CinemaVO>?> getCinemaDayTimeslot(
      String token, int movieId, String date) {
    return mApi
        .getCinemaDayTimeslot(token, movieId.toString(), date)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(
      String token, int timeslotId, String bookingDate) {
    return mApi
        .getCinemaSeatingPlan(token, timeslotId.toString(), bookingDate)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<SnackVO>?> getSnacks(String token) {
    return mApi
        .getSnacks(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethods(String token) {
    return mApi
        .getPaymentMethods(token)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<List<CardVO>?> getUserCards(String token) {
    return mApi
        .getUserProfile(token)
        .asStream()
        .map((response) => response.data?.cards)
        .first;
  }

  @override
  Future<String?> createCard(String token, String cardNumber, String cardHolder,
      String expirationDate, String cvc) {
    return mApi
        .createCard(token, cardNumber, cardHolder, expirationDate, cvc)
        .asStream()
        .map((response) => response.message)
        .first;
  }

  @override
  Future<VoucherVO?> checkout(String token, CheckoutRequest request) {
    return mApi
        .checkout(token, request)
        .asStream()
        .map((response) => response.data)
        .first;
  }
}
