import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/network/responses/auth_response.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/network/responses/checkout_response.dart';
import 'package:the_movie_booking_app/network/responses/cinema_timeslots_response.dart';
import 'package:the_movie_booking_app/network/responses/create_card_response.dart';
import 'package:the_movie_booking_app/network/responses/logout_response.dart';
import 'package:the_movie_booking_app/network/responses/movie_seats_response.dart';
import 'package:the_movie_booking_app/network/responses/payment_list_response.dart';
import 'package:the_movie_booking_app/network/responses/profile_response.dart';
import 'package:the_movie_booking_app/network/responses/snacks_response.dart';

part 'movie_booking_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class MovieBookingApi {
  factory MovieBookingApi(Dio dio) = _MovieBookingApi;

  @POST(ENDPOINT_REGISTER_WITH_EMAIL)
  @FormUrlEncoded()
  Future<AuthResponse> registerWithEmail(
    @Field(KEY_NAME) String name,
    @Field(KEY_EMAIL) String email,
    @Field(KEY_PHONE) String phone,
    @Field(KEY_PASSWORD) String password,
    @Field(KEY_GOOGLE_ACCESS_TOKEN) String googleAccessToken,
    @Field(KEY_FACEBOOK_ACCESS_TOKEN) String facebookAccessToken,
  );

  @POST(ENDPOINT_LOGOUT)
  Future<LogoutResponse> logout(@Header(KEY_AUTHORIZATION) String token);

  @POST(ENDPOINT_LOGIN_WITH_EMAIL)
  @FormUrlEncoded()
  Future<AuthResponse> loginWithEmail(
    @Field(KEY_EMAIL) String email,
    @Field(KEY_PASSWORD) String password,
  );

  @GET(ENDPOINT_GET_CINEMA_DAY_TIMESLOT)
  Future<CinemaTimeslotsResponse> getCinemaDayTimeslot(
    @Header(KEY_AUTHORIZATION) String token,
    @Query(PARAM_MOVIE_ID) String movieId,
    @Query(PARAM_DATE) String date,
  );

  @GET(ENDPOINT_CINEMA_SEATING_PLAN)
  Future<MovieSeatsResponse> getCinemaSeatingPlan(
    @Header(KEY_AUTHORIZATION) String token,
    @Query(PARAM_CINEMA_DAY_TIMESLOT_ID) String timeslotId,
    @Query(PARAM_BOOKING_DATE) String bookingDate,
  );

  @GET(ENDPOINT_GET_SNACK_LIST)
  Future<SnacksResponse> getSnacks(
    @Header(KEY_AUTHORIZATION) String token,
  );

  @GET(ENDPOINT_GET_PAYMENT_METHOD_LIST)
  Future<PaymentListResponse> getPaymentMethods(
    @Header(KEY_AUTHORIZATION) String token,
  );

  @GET(ENDPOINT_PROFILE)
  Future<ProfileResponse> getUserProfile(
    @Header(KEY_AUTHORIZATION) String token,
  );

  @POST(ENDPOINT_CREATE_CARD)
  @FormUrlEncoded()
  Future<CreateCardResponse> createCard(
    @Header(KEY_AUTHORIZATION) String token,
    @Field(KEY_CARD_NUMBER) String cardNumber,
    @Field(KEY_CARD_HOLDER) String cardHolder,
    @Field(KEY_EXPIRATION_DATE) String expirationDate,
    @Field(KEY_CVC) String cvc,
  );

  @POST(ENDPOINT_CHECKOUT)
  Future<CheckoutResponse> checkout(
    @Header(KEY_AUTHORIZATION) String token,
    @Body() CheckoutRequest request,
  );

  @POST(ENDPOINT_LOGIN_WITH_GOOGLE)
  @FormUrlEncoded()
  Future<AuthResponse> loginWithGoogle(
    @Field(KEY_ACCESS_TOKEN) String accessToken,
  );

  @POST(ENDPOINT_LOGIN_WITH_FACEBOOK)
  @FormUrlEncoded()
  Future<AuthResponse> loginWithFacebook(
    @Field(KEY_ACCESS_TOKEN) String accessToken,
  );
}
