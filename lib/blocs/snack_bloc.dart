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
  bool selectPaymentTrigger = false;
  bool snacksQtyTrigger = false;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  SnackBloc(double ticketsPrice) {
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
    paymentMethods?.forEach((each) {
      if (each.id == paymentId) {
        each.isSelected = true;
      } else {
        each.isSelected = false;
      }
    });
    selectPaymentTrigger = !selectPaymentTrigger;
    notifyListeners();
  }

  void onTapSnackQtyDecrease(SnackVO? snack) {
    if ((snack?.quantity ?? 0) > 0) {
      subTotal -= snack?.price ?? 0;
    }
    snacks?.forEach((each) {
      if (each.id == snack?.id) {
        if ((each.quantity) > 0) {
          each.quantity = (each.quantity) - 1;
        }
      }
    });
    snacksQtyTrigger = !snacksQtyTrigger;
    notifyListeners();
  }

  void onTapSnackQtyIncrease(SnackVO? snack) {
    snacks?.forEach((each) {
      if (each.id == snack?.id) {
        each.quantity = (each.quantity) + 1;
      }
    });
    subTotal += snack?.price ?? 0;
    snacksQtyTrigger = !snacksQtyTrigger;
    notifyListeners();
  }

}
