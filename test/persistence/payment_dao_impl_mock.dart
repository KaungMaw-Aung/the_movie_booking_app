import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/persistence/daos/payment_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentDaoImplMock extends PaymentDao {

  Map<int, PaymentVO> paymentsFromDatabaseMock = {};

  @override
  Stream<void> getAllEventsFromPaymentBox() {
    return Stream<void>.value(null);
  }

  @override
  List<PaymentVO> getAllPayments() {
    return getMockPayments();
  }

  @override
  Stream<List<PaymentVO>> getPaymentsStream() {
    return Stream.value(getAllPayments());
  }

  @override
  void savePayments(List<PaymentVO> payments) {
    payments.forEach((element) {
      paymentsFromDatabaseMock[element.id ?? -1] = element;
    });
  }

}