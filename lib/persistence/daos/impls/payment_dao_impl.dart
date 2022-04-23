import 'package:hive/hive.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';
import 'package:the_movie_booking_app/persistence/persistence_constants.dart';

class PaymentDaoImpl extends PaymentDao {

  static final PaymentDaoImpl _singleton = PaymentDaoImpl._internal();

  factory PaymentDaoImpl() => _singleton;

  PaymentDaoImpl._internal();

  void savePayments(List<PaymentVO> payments) async {
    Map<int, PaymentVO> paymentMap = Map.fromIterable(
        payments, key: (payment) => payment.id, value: (payment) => payment);
    await getPaymentBox().putAll(paymentMap);
  }

  @override
  List<PaymentVO> getAllPayments() {
    return getPaymentBox().values.toList();
  }

  /// reactive programming
  @override
  Stream<void> getAllEventsFromPaymentBox() {
    return getPaymentBox().watch();
  }

  @override
  Stream<List<PaymentVO>> getPaymentsStream() {
    return Stream.value(
      getAllPayments()
    );
  }

  Box<PaymentVO> getPaymentBox() {
    return Hive.box<PaymentVO>(BOX_NAME_PAYMENT_VO);
  }

}