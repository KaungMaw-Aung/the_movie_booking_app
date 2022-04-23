import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_booking_data_agent_impl_mock.dart';
import '../persistence/cast_dao_impl_mock.dart';
import '../persistence/cinema_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';
import '../persistence/payment_dao_impl_mock.dart';
import '../persistence/snack_dao_impl_mock.dart';
import '../persistence/user_dao_impl_mock.dart';

void main() {
  group("movie booking model impl test", () {
    var movieBookingModel = MovieBookingModelImpl();

    setUp(() {
      movieBookingModel.setDaosAndDataAgents(
        MovieBookingDataAgentImplMock(),
        UserDaoImplMock(),
        MovieDaoImplMock(),
        CastDaoImplMock(),
        SnackDaoImplMock(),
        CinemaDaoImplMock(),
        PaymentDaoImplMock(),
      );
    });

    test("Register With Email Test", () {
      expect(
        movieBookingModel.registerWithEmail('', '', '', '', '', ''),
        completion(
          equals("Register Succeed"),
        ),
      );
    });

    test("Logout Test", () {
      expect(
        movieBookingModel.logout(),
        completion(
          equals(
            getLogOutSucceedMessage(),
          ),
        ),
      );
    });

    test("Login With Email Test", () {
      expect(
        movieBookingModel.loginWithEmail('', ''),
        completion(
          equals("Login Succeed"),
        ),
      );
    });

    test("Login With Google Test", () {
      expect(
        movieBookingModel.loginWithGoogle(''),
        completion(
          equals("Login Succeed"),
        ),
      );
    });

    test("Login With Facebook Test", () {
      expect(
        movieBookingModel.loginWithFacebook(''),
        completion(
          equals("Login Succeed"),
        ),
      );
    });

    test("Get Cinema Seating Plan Test", () {
      expect(
        movieBookingModel.getCinemaSeatingPlan(0, ''),
        completion(
          equals([
            getMockMovieSeats().expand((seats) => seats).toList(),
            getMockMovieSeats().first.length
          ]),
        ),
      );
    });

    test("Create Card Test", () {
      completion(equals(createNewCardSucceedMessage()));
    });

    test("Checkout Test", () {
      expect(
          movieBookingModel
              .checkout(CheckoutRequest(0, "", "", "", 0.0, 0, 0, 0, [])),
          completion(equals(getMockVoucher())));
    });

    test("Get User From Database Test", () {
      expect(
        movieBookingModel.getUserFromDatabase(),
        emits(
          getMockUser(),
        ),
      );
    });

    test("Get Now Playing From Database Test", () {
      expect(
        movieBookingModel.getNowPlayingFromDatabase(),
        emits(
          getMockMovies().where((element) => element.isNowPlaying).toList(),
        ),
      );
    });

    test("Get Coming Soon From Database Test", () {
      expect(
        movieBookingModel.getComingSoonFromDatabase(),
        emits(
          getMockMovies().where((element) => element.isComingSoon).toList(),
        ),
      );
    });

    test("Get Movie Details From Database Test", () {
      expect(
        movieBookingModel.getMovieDetailByIdFromDatabase(634649),
        emits(
          getMockMovie(),
        ),
      );
    });

    test("Get Casts By Movie Id From Database Test", () {
      expect(
        movieBookingModel.getCastsByMovieIdFromDatabase(508947),
        emits(
          [getMockCasts().first],
        ),
      );
    });

    test("Get Snacks From Database Test", () {
      expect(
        movieBookingModel.getSnacksFromDatabase(),
        emits(
          getMockSnacks(),
        ),
      );
    });

    test("Get Cinemas From Database Test", () {
      expect(
        movieBookingModel.getCinemasFromDatabase(0, "2022-04-22"),
        emits(
          getMockCinemas(),
        ),
      );
    });

    test("Get Payment Methods From Database", () {
      expect(
        movieBookingModel.getPaymentMethodsFromDatabase(),
        emits(
          getMockPayments(),
        ),
      );
    });

    test("Get User Cards From Database", () {
      expect(
        movieBookingModel.getUserCardsFromDatabase(),
        emits(
          getMockCards(),
        ),
      );
    });

  });
}
