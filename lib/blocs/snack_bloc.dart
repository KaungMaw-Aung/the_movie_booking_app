import 'package:flutter/foundation.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';

class SnackBloc extends ChangeNotifier {
  /// state variables
  List<PaymentVO>? paymentMethods;
  List<SnackVO>? snacks;
  double subTotal = 0;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  SnackBloc(double ticketsPrice, [MovieBookingModel? _movieBookingModel]) {

    if (_movieBookingModel != null) {
      movieBookingModel = _movieBookingModel;
    }

    /// get snacks
    movieBookingModel.getSnacksFromDatabase().listen((snackList) {
      snacks = snackList;
      subTotal = ticketsPrice;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));

    /// get payment methods
    movieBookingModel.getPaymentMethodsFromDatabase().listen((value) {
      paymentMethods = value;
      notifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }

  void onTapPayment(int paymentId) {
    paymentMethods = paymentMethods?.map((each) {
      if (each.id == paymentId) {
        each.isSelected = true;
      } else {
        each.isSelected = false;
      }
      return each;
    }).toList();

    notifyListeners();
  }

  void onTapSnackQtyDecrease(SnackVO? snack) {
    if ((snack?.quantity ?? 0) > 0) {
      subTotal -= snack?.price ?? 0;
    }
    snacks = snacks?.map((each) {
      if (each.id == snack?.id) {
        if ((each.quantity) > 0) {
          each.quantity = (each.quantity) - 1;
        }
      }
      return each;
    }).toList();

    notifyListeners();
  }

  void onTapSnackQtyIncrease(SnackVO? snack) {
    subTotal += snack?.price ?? 0;
    snacks = snacks?.map((each) {
      if (each.id == snack?.id) {
        each.quantity = (each.quantity) + 1;
      }
      return each;
    }).toList();

    notifyListeners();
  }

}
