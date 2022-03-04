import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

import 'data/models/movie_booking_model.dart';
import 'data/models/movie_booking_model_impl.dart';
import 'data/vos/cast_vo.dart';
import 'data/vos/genre_vo.dart';
import 'data/vos/movie_vo.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(CastVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(TimeslotVOAdapter());
  Hive.registerAdapter(CinemaListForHiveVOAdapter());
  Hive.registerAdapter(PaymentVOAdapter());

  await Hive.openBox<UserVO>(BOX_NAME_USER_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CastVO>(BOX_NAME_CAST_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<PaymentVO>(BOX_NAME_PAYMENT_VO);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  /// state variables
  UserVO? user;

  @override
  void initState() {

    movieBookingModel
        .getUserFromDatabase()
        .listen((user) {
          setState(() {
            this.user = user;
          });
        })
        .onError((error) => debugPrint(error.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
          iconTheme: IconThemeData(
            color: Colors.black,
            opacity: 1.0,
            size: MARGIN_XLARGE,
          ),
          elevation: 0,
        ),
        scaffoldBackgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
      ),
      home: (user == null) ? WelcomePage() : HomePage(),
    );
  }
}
