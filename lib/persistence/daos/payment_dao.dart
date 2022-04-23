import 'package:the_movie_booking_app/data/vos/payment_vo.dart';

abstract class PaymentDao {

  void savePayments(List<PaymentVO> payments);

  List<PaymentVO> getAllPayments();

  Stream<void> getAllEventsFromPaymentBox();

  Stream<List<PaymentVO>> getPaymentsStream();

}