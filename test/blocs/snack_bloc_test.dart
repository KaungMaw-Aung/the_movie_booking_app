import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/snack_bloc.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

import '../data.models/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Snack Bloc Test", () {
    SnackBloc? snackBloc;

    setUp(() {
      snackBloc = SnackBloc(3.0, MovieBookingModelImplMock());
    });

    test("Get Snacks Test", () {
      expect(snackBloc?.snacks, getMockSnacks());
    });

    test("Get Payment Methods Test", () {
      expect(snackBloc?.paymentMethods, getMockPayments());
    });

    test("On Tap Payment Test", () async {
      snackBloc?.onTapPayment(1);
      expect(snackBloc?.paymentMethods?.first.isSelected, true);
    });

    test("On Tap Snack Quantity Decrease Test", () {
      snackBloc?.onTapSnackQtyDecrease(
        SnackVO(
          1,
          "Popcorn",
          "Et dolores eaque officia aut.",
          2.0,
          quantity: 1,
        ),
      );
      expect(snackBloc?.snacks?.first.quantity, 0);
      expect(snackBloc?.subTotal, 1.0);
    });

    test("On Tap Snack Quantity Increase Test", () {
      snackBloc?.onTapSnackQtyIncrease(
        SnackVO(
          1,
          "Popcorn",
          "Et dolores eaque officia aut.",
          2.0,
          quantity: 1,
        ),
      );
      expect(snackBloc?.snacks?.first.quantity, 2);
      expect(snackBloc?.subTotal, 5.0);
    });

  });
}
