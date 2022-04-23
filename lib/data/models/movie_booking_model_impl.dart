import 'package:intl/intl.dart';
import 'package:stream_transform/stream_transform.dart';
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
import 'package:the_movie_booking_app/network/data_agents/movie_booking_data_agent.dart';
import 'package:the_movie_booking_app/network/data_agents/movie_booking_retrofit_data_agent_impl.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/persistence/daos/cast_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/cinema_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/impls/cast_dao_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/impls/cinema_dao_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/impls/movie_dao_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/impls/payment_dao_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/impls/snack_dao_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/impls/user_dao_impl.dart';
import 'package:the_movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/snack_dao.dart';
import 'package:the_movie_booking_app/persistence/daos/user_dao.dart';
import 'package:the_movie_booking_app/utils/utils.dart';

class MovieBookingModelImpl extends MovieBookingModel {
  static final MovieBookingModelImpl _singleton =
      MovieBookingModelImpl._internal();

  factory MovieBookingModelImpl() => _singleton;

  MovieBookingModelImpl._internal();

  /// data agent
  MovieBookingDataAgent dataAgent = MovieBookingRetrofitDataAgentImpl();

  /// dao
  UserDao userDao = UserDaoImpl();
  MovieDao movieDao = MovieDaoImpl();
  CastDao castDao = CastDaoImpl();
  SnackDao snackDao = SnackDaoImpl();
  CinemaDao cinemaDao = CinemaDaoImpl();
  PaymentDao paymentDao = PaymentDaoImpl();

  /// for testing purpose
  void setDaosAndDataAgents(
    MovieBookingDataAgent _dataAgent,
    UserDao _userDao,
    MovieDao _movieDao,
    CastDao _castDao,
    SnackDao _snackDao,
    CinemaDao _cinemaDao,
    PaymentDao _paymentDao,
  ) {
    dataAgent = _dataAgent;
    userDao = _userDao;
    movieDao = _movieDao;
    castDao = _castDao;
    snackDao = _snackDao;
    cinemaDao = _cinemaDao;
    paymentDao = _paymentDao;
  }

  /// network
  @override
  Future<String?> registerWithEmail(String name, String email, String phone,
      String password, String? googleToken, String? facebookToken) {
    return dataAgent
        .registerWithEmail(
            name, email, phone, password, googleToken, facebookToken)
        .then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUser(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> logout() {
    return getUserFromDatabase().first.then((user) {
      return dataAgent.logout(user?.getBearerToken() ?? "");
    });
  }

  @override
  Future<String?> loginWithEmail(String email, String password) {
    return dataAgent.loginWithEmail(email, password).then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;
      print("User: ${user.toString()}");
      userDao.saveUser(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> loginWithGoogle(String accessToken) {
    return dataAgent.loginWithGoogle(accessToken).then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUser(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> loginWithFacebook(String accessToken) {
    return dataAgent.loginWithFacebook(accessToken).then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUser(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  void getNowPlayingMovies(int page) {
    dataAgent.getNowPlayingMovies(page).then((movies) {
      movies?.forEach((movie) => movie.isNowPlaying = true);
      movieDao.saveMovies(movies ?? []);
    });
  }

  @override
  void getComingSoonMovies(int page) {
    dataAgent.getComingSoonMovies(page).then((movies) {
      movies?.forEach((movie) => movie.isComingSoon = true);
      movieDao.saveMovies(movies ?? []);
    });
  }

  @override
  void getMovieDetail(int movieId) {
    dataAgent.getMovieDetails(movieId).then((movie) {
      if (movie != null) {
        movieDao.saveMovieDetail(movie);
      }
    });
  }

  @override
  void getMovieCredit(int movieId) {
    dataAgent.getMovieCredit(movieId).then((casts) {
      List<int> castIds =
          castDao.getCasts().map((each) => each.id ?? -1).toList();
      casts?.forEach((cast) {
        if (castIds.contains(cast.id)) {
          castDao.updateCastInMovie(cast.id!, movieId);
        } else {
          cast.movieIds = [movieId];
          castDao.saveCast(cast);
        }
      });
    });
  }

  @override
  void getCinemaDayTimeslot(int movieId, String date) {
    getUserFromDatabase().first.then((user) {
      dataAgent
          .getCinemaDayTimeslot(
        user?.getBearerToken() ?? "",
        movieId,
        date,
      )
          .then((cinemas) {
        if (cinemas != null) {
          cinemaDao.saveCinemas(cinemas, date);
        }
      });
    });
  }

  @override
  Future<List<dynamic>?> getCinemaSeatingPlan(int timeslotId, String date) {
    return getUserFromDatabase().first.then((user) {
      return dataAgent
          .getCinemaSeatingPlan(user?.getBearerToken() ?? "", timeslotId, date)
          .asStream()
          .map((seats) {
        return [
          seats?.expand((seatList) => seatList).toList(),
          seats?[0].length
        ];
      }).first;
    });
  }

  @override
  void getSnacks() {
    getUserFromDatabase().first.then((user) {
      dataAgent.getSnacks(user?.getBearerToken() ?? "").then((snacks) {
        snackDao.saveAllSnacks(snacks ?? []);
      });
    });
  }

  @override
  void getPaymentMethods() {
    getUserFromDatabase().first.then((user) {
      dataAgent
          .getPaymentMethods(user?.getBearerToken() ?? "")
          .then((payments) {
        if (payments != null) {
          paymentDao.savePayments(payments);
        }
      });
    });
  }

  @override
  Future<bool> getUserCards() {
    return getUserFromDatabase().first.then((user) {
      return dataAgent.getUserCards(user?.getBearerToken() ?? "").then((cards) {
        var temp = userDao.getUser();
        temp?.cards = cards;
        if (temp != null) {
          userDao.saveUser(temp);
          return true;
        } else {
          return false;
        }
      });
    });
  }

  @override
  Future<String?> createCard(
      String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return getUserFromDatabase().first.then((user) {
      return dataAgent.createCard(user?.getBearerToken() ?? "", cardNumber,
          cardHolder, expirationDate, cvc);
    });
  }

  @override
  Future<VoucherVO?> checkout(CheckoutRequest request) {
    return getUserFromDatabase().first.then((user) {
      return dataAgent.checkout(user?.getBearerToken() ?? "", request);
    });
  }

  /// database
  @override
  Stream<UserVO?> getUserFromDatabase() {
    return userDao
        .getAllEventsFromUserBox()
        .startWith(userDao.getUserStream())
        .map((event) => userDao.getUser());
  }

  @override
  void deleteUserFromDatabase() {
    userDao.deleteUser();
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingFromDatabase() {
    getNowPlayingMovies(1);
    return movieDao
        .getAllEventsFromMovieBox()
        .startWith(movieDao.getNowPlayingMoviesStream())
        .map((event) => movieDao.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>?> getComingSoonFromDatabase() {
    getComingSoonMovies(1);
    return movieDao
        .getAllEventsFromMovieBox()
        .startWith(movieDao.getComingSoonMoviesStream())
        .map((event) => movieDao.getComingSoonMovies());
  }

  @override
  Stream<MovieVO?> getMovieDetailByIdFromDatabase(int movieId) {
    getMovieDetail(movieId);
    return movieDao
        .getAllEventsFromMovieBox()
        .startWith(movieDao.getMovieDetailsStreamById(movieId))
        .map((event) => movieDao.getMovieById(movieId));
  }

  @override
  Stream<List<CastVO>> getCastsByMovieIdFromDatabase(int movieId) {
    getMovieCredit(movieId);
    return castDao
        .getAllEventsFromCastBox()
        .startWith(castDao.getCastsStreamByMovieId(movieId))
        .map((event) => castDao.getCastsByMovieId(movieId));
  }

  @override
  Stream<List<SnackVO>> getSnacksFromDatabase() {
    return snackDao
        .getAllEventsFromSnackBox()
        .startWith(snackDao.getSnacksStream())
        .map((event) => snackDao.getAllSnacks());
  }

  @override
  Stream<List<CinemaVO>?> getCinemasFromDatabase(int movieId, String date) {
    getCinemaDayTimeslot(movieId, date);
    return cinemaDao
        .getAllEventsFromCinemaBox()
        .startWith(cinemaDao.getCinemasStreamByDate(date))
        .map((event) => cinemaDao.getCinemaByDate(date));
  }

  @override
  Future<List<DateVO>> getDates() {
    List<DateVO> dates =
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map((numberOfDays) {
      return DateTime.now().add(Duration(days: numberOfDays));
    }).map((dateTime) {
      return DateVO(
        dateTime.day.toString(),
        convertToDay(dateTime.weekday),
        DateFormat("yyyy-MM-dd").format(dateTime),
        false,
      );
    }).toList();
    dates.first.isSelected = true;
    return Future.value(dates);
  }

  @override
  Stream<List<PaymentVO>> getPaymentMethodsFromDatabase() {
    getPaymentMethods();
    return paymentDao
        .getAllEventsFromPaymentBox()
        .startWith(paymentDao.getPaymentsStream())
        .map((event) => paymentDao.getAllPayments());
  }

  @override
  Stream<List<CardVO>?> getUserCardsFromDatabase() {
    getUserCards();
    return userDao
        .getAllEventsFromUserBox()
        .startWith(userDao.getUserCardsStream())
        .map((event) => userDao.getUserCards());
  }
}
