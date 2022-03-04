import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class PaymentDao {

  static final PaymentDao _singleton = PaymentDao._internal();

  factory PaymentDao() => _singleton;

  PaymentDao._internal();

  void savePayments(List<PaymentVO> payments) async {
    Map<int, PaymentVO> paymentMap = Map.fromIterable(
        payments, key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentBox().putAll(paymentMap);
  }

  List<PaymentVO> getAllPayments() {
    return getPaymentBox().values.toList();
  }

  /// reactive programming
  Stream<void> getAllEventsFromPaymentBox() {
    return getPaymentBox().watch();
  }

  Stream<List<PaymentVO>> getPaymentsStream() {
    return Stream.value(
      getAllPayments()
    );
  }

  Box<PaymentVO> getPaymentBox() {
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }

}