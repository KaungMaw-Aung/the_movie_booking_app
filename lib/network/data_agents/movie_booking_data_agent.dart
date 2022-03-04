import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/network/responses/checkout_response.dart';

abstract class MovieBookingDataAgent {
  Future<List<dynamic>> registerWithEmail(
    String name,
    String email,
    String phone,
    String password,
    String? googleAccessToken,
    String? facebookAccessToken,
  );

  Future<String?> logout(String token);

  Future<List<dynamic>> loginWithEmail(String email, String password);

  Future<List<dynamic>> loginWithGoogle(String accessToken);

  Future<List<dynamic>> loginWithFacebook(String accessToken);

  Future<List<MovieVO>?> getNowPlayingMovies(int page);

  Future<List<MovieVO>?> getComingSoonMovies(int page);

  Future<MovieVO?> getMovieDetails(int movieId);

  Future<List<CastVO>?> getMovieCredit(int movieId);

  Future<List<CinemaVO>?> getCinemaDayTimeslot(
      String token, int movieId, String date);

  Future<List<List<MovieSeatVO>>?> getCinemaSeatingPlan(
    String token,
    int timeslotId,
    String bookingDate,
  );

  Future<List<SnackVO>?> getSnacks(String token);

  Future<List<PaymentVO>?> getPaymentMethods(String token);

  Future<List<CardVO>?> getUserCards(String token);

  Future<String?> createCard(
    String token,
    String cardNumber,
    String cardHolder,
    String expirationDate,
    String cvc,
  );

  Future<VoucherVO?> checkout(
    String token,
    CheckoutRequest request,
  );


}
