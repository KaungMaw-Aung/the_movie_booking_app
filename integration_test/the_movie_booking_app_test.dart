import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_list_for_hive_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/main.dart';
import 'package:the_movie_booking_app/pages/add_new_card_page.dart';
import 'package:the_movie_booking_app/pages/choose_card_page.dart';
import 'package:the_movie_booking_app/pages/movie_seats_page.dart';
import 'package:the_movie_booking_app/pages/movie_snack_page.dart';
import 'package:the_movie_booking_app/pages/ticket_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';
import 'package:the_movie_booking_app/viewitems/movie_seat_item_view.dart';
import 'package:the_movie_booking_app/widgets/input_field_section_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

import 'test_data/test_data.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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

  testWidgets("Test the movie booking app complete flow",
      (WidgetTester tester) async {

    var delayFiveSec = const Duration(seconds: 5);

    await tester.pumpWidget(const MyApp());
    await Future.delayed(const Duration(seconds: 2));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    // check if Welcome Page appeared
    expect(find.byType(WelcomePage), findsOneWidget);
    expect(find.text(GET_STARTED_BUTTON_TEXT), findsOneWidget);

    // tap on Get Started and navigate to Login Page
    await tester.tap(find.text(GET_STARTED_BUTTON_TEXT));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // check if Login Page appeared
    expect(find.text(LOGIN_SCREEN_WELCOME_TEXT), findsOneWidget);
    expect(find.text(EMAIL_LABEL_TEXT), findsOneWidget);
    expect(find.text(PASSWORD_LABEL_TEXT), findsOneWidget);

    // enter email
    await tester.tap(find.byType(InputFieldSectionView).first);
    tester.testTextInput.enterText(EMAIL);

    // enter password
    await tester.tap(find.byType(InputFieldSectionView).last);
    tester.testTextInput.enterText(PASSWORD);

    // tap confirm button
    await tester.tap(find.text(CONFIRM_BUTTON_TEXT));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // check if Home Page appeared
    expect(find.text(USERNAME), findsOneWidget);
    expect(find.text(NOW_SHOWING_TITLE_HOME_PAGE), findsOneWidget);
    expect(find.text(COMING_SOON_TITLE_HOME_PAGE), findsOneWidget);

    // check for now showing and coming soon movies
    expect(find.text(NOW_SHOWING_FIRST_MOVIE_NAME), findsOneWidget);
    expect(find.text(COMING_SOON_FIRST_MOVIE_NAME), findsOneWidget);

    // tap a movie and navigate to Movie Detail Page
    await tester.tap(find.text(NOW_SHOWING_FIRST_MOVIE_NAME));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // check if Movie Detail Page appeared
    expect(find.text(NOW_SHOWING_FIRST_MOVIE_NAME), findsOneWidget);
    // expect(find.text(SHOW_DURATION), findsOneWidget);
    expect(find.text(SHOW_RATING), findsOneWidget);

    // tap Get Your Ticket button
    await tester.tap(find.text(GET_YOUR_TICKET_MOVIE_DETAIL_PAGE));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // check if Timeslot Page appeared
    expect(find.text(CINEMA_ONE_TIMESLOT_PAGE), findsOneWidget);
    expect(find.text(CINEMA_TWO_TIMESLOT_PAGE), findsOneWidget);
    expect(find.text(CINEMA_THREE_TIMESLOT_PAGE), findsOneWidget);
    expect(find.byKey(const Key(DATE_KEY_ZERO_TIMESLOT_PAGE)), findsOneWidget);

    // tap on Date item
    await tester.tap(find.byKey(const Key(DATE_KEY_ONE_TIMESLOT_PAGE)));
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // check if cinemas appeared
    expect(find.text(CINEMA_ONE_TIMESLOT_PAGE), findsOneWidget);
    expect(find.text(CINEMA_TWO_TIMESLOT_PAGE), findsOneWidget);
    expect(find.text(CINEMA_THREE_TIMESLOT_PAGE), findsOneWidget);

    // choose timeslots
    await tester.tap(find.text(MOVIE_TIME_NINE_THIRTY).first);
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await tester.tap(find.text(MOVIE_TIME_TEN));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // tap Next Button and navigate
    await tester.tap(find.text(NEXT_BUTTON_TEXT));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // check if Movie Seats Page appeared
    expect(find.text(NOW_SHOWING_FIRST_MOVIE_NAME), findsOneWidget);
    expect(find.text(CINEMA_TWO_TIMESLOT_PAGE), findsOneWidget);

    // verify that ticket count is 0 and total is 0.0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    expect(find.text(TOTAL_PRICE_ZERO), findsOneWidget);
    expect(find.text(TOTAL_PRICE_THREE), findsNothing);

    // tap seat C-2
    await tester.tap(find.byKey(const Key(MOVIE_SEAT_C2_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text(TOTAL_PRICE_THREE), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text(SELECTED_MOVIE_SEAT_C2), findsWidgets);

    // tap seat C-3
    await tester.tap(find.byKey(const Key(MOVIE_SEAT_C3_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text(TOTAL_PRICE_SIX), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text(SELECTED_MOVIE_SEAT_C2_C3), findsOneWidget);

    // verify that seats C-1=2, C-3 are selected and other unselected
    expect(find.text(SELECTED_MOVIE_SEAT_C2), findsOneWidget);
    expect(find.text(SELECTED_MOVIE_SEAT_C3), findsOneWidget);
    expect(find.text(UNSELECTED_MOVIE_SEAT_C4), findsNothing);

    // unselect seat C-3
    await tester.tap(find.byKey(const Key(MOVIE_SEAT_C3_KEY)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text(TOTAL_PRICE_SIX), findsNothing);
    expect(find.text(TOTAL_PRICE_THREE), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text(SELECTED_MOVIE_SEAT_C2), findsWidgets);

    // tap buy ticket button and navigate to Snack Page
    // expect(find.byType(Scrollable), findsNWidgets(2));
    await tester.scrollUntilVisible(find.text(TOTAL_PRICE_THREE), 500.0, scrollable: find.byType(Scrollable).first);
    await tester.tap(find.byType(PrimaryButtonView), warnIfMissed: false);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // verify that Snack Page appeared
    expect(find.byType(MovieSnackPage), findsOneWidget);
    expect(find.text(SNACK_POPCORN), findsOneWidget);
    expect(find.text(SNACK_SMOOTHIES), findsOneWidget);
    expect(find.text(SNACK_CARROTS), findsOneWidget);

    // check starting quantity and price
    expect(find.text('0'), findsNWidgets(3));
    expect(find.text(SUBTOTAL_3), findsOneWidget);
    expect(find.text(PAY_3), findsOneWidget);

    // increase popcorn quantity by one
    await tester.tap(find.byKey(const Key(POPCORN_BUTTON_KEY)).last);
    await tester.pumpAndSettle(delayFiveSec);

    // verify that popcorn quantity increased
    expect(find.text('0'), findsNWidgets(2));
    expect(find.text('1'), findsOneWidget);
    expect(find.text(SUBTOTAL_5), findsOneWidget);
    expect(find.text(PAY_5), findsOneWidget);

    // increase smoothies quantity by one
    await tester.tap(find.byKey(const Key(SMOOTHIES_BUTTON_KEY)).last);
    await tester.pumpAndSettle(delayFiveSec);

    // verify that smoothies quantity increased
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNWidgets(2));
    expect(find.text(SUBTOTAL_8), findsOneWidget);
    expect(find.text(PAY_8), findsOneWidget);

    // increase carrots quantity by one
    await tester.tap(find.byKey(const Key(CARROTS_BUTTON_KEY)).last);
    await tester.pumpAndSettle(delayFiveSec);

    // verify that smoothies quantity increased
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsNWidgets(3));
    expect(find.text(SUBTOTAL_12), findsOneWidget);
    expect(find.text(PAY_12), findsOneWidget);

    // decrease each quantity
    await tester.tap(find.text("-").first);
    await tester.pumpAndSettle(delayFiveSec);
    await tester.tap(find.text("-").at(1));
    await tester.pumpAndSettle(delayFiveSec);
    await tester.tap(find.text("-").last);
    await tester.pumpAndSettle(delayFiveSec);

    expect(find.text('0'), findsNWidgets(3));
    expect(find.text(SUBTOTAL_3), findsOneWidget);
    expect(find.text(PAY_3), findsOneWidget);

    // increase popcorn quantity by one
    await tester.tap(find.byKey(const Key(POPCORN_BUTTON_KEY)).last);
    await tester.pumpAndSettle(delayFiveSec);

    // verify that popcorn quantity increased
    expect(find.text('0'), findsNWidgets(2));
    expect(find.text('1'), findsOneWidget);
    expect(find.text(SUBTOTAL_5), findsOneWidget);
    expect(find.text(PAY_5), findsOneWidget);

    // choose Credit card payment method
    await tester.tap(find.text(CREDIT_CARD));
    await tester.pumpAndSettle(delayFiveSec);

    // tap Pay button and navigate to Choose Card Page
    await tester.tap(find.text(PAY_5));
    await tester.pumpAndSettle(delayFiveSec);

    // verify that Choose Card Page appeared
    expect(find.byType(ChooseCardPage), findsOneWidget);
    expect(find.text(PAYMENT_AMOUNT), findsOneWidget);
    expect(find.text(FIVE_DOLLAR), findsOneWidget);

    // tap add new card and navigate to Add New Card Page
    await tester.tap(find.text(ADD_NEW_CARD));
    await tester.pumpAndSettle(delayFiveSec);

    // verify that Add New Card Page appeared
    expect(find.byType(AddNewCardPage), findsOneWidget);

    // fill fields for new card
    await tester.tap(find.byType(InputFieldSectionView).first);
    tester.testTextInput.enterText(NEW_CARD_NUMBER);
    await tester.tap(find.byType(InputFieldSectionView).at(1));
    tester.testTextInput.enterText(NEW_CARD_HOLDER);
    await tester.tap(find.byType(InputFieldSectionView).at(2));
    tester.testTextInput.enterText(NEW_CARD_EXPIRE_DATE);
    await tester.tap(find.byType(InputFieldSectionView).last);
    tester.testTextInput.enterText(NEW_CARD_CVC);

    // tap Confirm button and back to Choose Card Page
    await tester.tap(find.text(CONFIRM_BUTTON_TEXT));
    await tester.pumpAndSettle(delayFiveSec);

    // verify that newly added card is there
    expect(find.byType(ChooseCardPage), findsOneWidget);
    expect(find.text(NEW_CARD_NUMBER), findsOneWidget);
    expect(find.text(NEW_CARD_HOLDER), findsOneWidget);

    // tap confirm button and navigate to Ticket Page
    await tester.tap(find.text(PURCHASE));
    await tester.pumpAndSettle(delayFiveSec);

    // verify that Ticket Page appeared
    expect(find.byType(TicketPage), findsOneWidget);
    expect(find.text(AWESOME), findsOneWidget);
    expect(find.text(THIS_IS_YOUR_TICKET), findsOneWidget);

    // verify ticket info
    expect(find.text(NOW_SHOWING_FIRST_MOVIE_NAME), findsOneWidget);
    expect(find.text(CINEMA_TWO_TIMESLOT_PAGE), findsOneWidget);
    expect(find.text("2"), findsOneWidget);
    expect(find.text("C"), findsOneWidget);
    expect(find.text("C-1"), findsOneWidget);
    expect(find.text("\$5"), findsOneWidget);

  });
}
