import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/choose_card_bloc.dart';

import '../data.models/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Choose Card Bloc Test", () {

    ChooseCardBloc? chooseCardBloc;

    setUp(() {
      chooseCardBloc = ChooseCardBloc(MovieBookingModelImplMock());
    });

    test("Get User Cards Test", () {
      expect(chooseCardBloc?.cards, getMockCards());
    });

    test("On Card Change Test", () {
      chooseCardBloc?.onCardChange(1);
      expect(chooseCardBloc?.getSelectedCardId(), getMockCards()[1].id);
    });

  });

}