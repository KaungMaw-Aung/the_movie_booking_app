import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/ticket_bloc.dart';

import '../mock_data/mock_data.dart';

void main() {
  TicketBloc ticketBloc = TicketBloc(voucher: getMockVoucher(),
    moviePosterUrl: "poster.jpg",
    movieTitle: "Test Movie",
    cinema: "Test Cinema",);

  test("Get Voucher Test", () {
    expect(ticketBloc.voucher, getMockVoucher());
    expect(ticketBloc.moviePosterUrl, "poster.jpg");
    expect(ticketBloc.movieTitle, "Test Movie");
    expect(ticketBloc.cinema, "Test Cinema");
  });
}