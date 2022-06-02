import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/choose_time_bloc.dart';

import '../data.models/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Choose Time Bloc Test", () {

    ChooseTimeBloc? chooseTimeBloc;

    test("Get Dates Test", () {
      expect(chooseTimeBloc?.dates, getMockDates());
    });

    setUp(() {
      chooseTimeBloc = ChooseTimeBloc(0, MovieBookingModelImplMock());
    });

    test("Get Cinemas With Current Date Test", () async {
      await Future.delayed(const Duration(seconds: 3));
      expect(chooseTimeBloc?.cinemas, getMockCinemas());
    });

    test("Get Cinemas With User Selected Date Test", () async {
      await Future.delayed(const Duration(seconds: 3));
      chooseTimeBloc?.onTapDate(1);
      await Future.delayed(const Duration(seconds: 3));
      expect(chooseTimeBloc?.cinemas, []);
    });

    test("On Tap Timeslot Test", () {
      chooseTimeBloc?.onTapTimeslot(0, "9:00 AM");
      expect(chooseTimeBloc?.selectedTimeslotId, 0);
      expect(chooseTimeBloc?.movieTime, "9:00 AM");
    });

  });

}