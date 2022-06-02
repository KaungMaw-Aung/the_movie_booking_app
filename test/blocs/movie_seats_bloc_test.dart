import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/movie_seats_bloc.dart';

import '../data.models/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Seats Bloc Test", () {
    MovieSeatsBloc? movieSeatBloc;

    setUp(() {
      movieSeatBloc = MovieSeatsBloc(0, "", MovieBookingModelImplMock());
    });

    test("Get Seats And Seat Count In A Row Test", () {
      expect(
        movieSeatBloc?.movieSeats,
        getMockMovieSeats().expand((seats) => seats).toList(),
      );

      expect(movieSeatBloc?.countInARow, getMockMovieSeats().first.length);
    });

    test("On Tap Movie Seat Tap", () async {
      /// Select State
      movieSeatBloc?.onTapMovieSeat(movieSeatBloc?.movieSeats?[2]);

      expect(
        movieSeatBloc?.movieSeats,
        getMockMovieSeats().expand((seats) => seats).toList().map(
          (e) {
            if (e.id == 3 && e.symbol == "A") {
              e.isSelected = true;
            }
            return e;
          },
        ),
      );
      expect(movieSeatBloc?.selectedSeats, ["A-2"]);
      expect(movieSeatBloc?.totalPrice, 2);

      /// Unselect State
      movieSeatBloc?.onTapMovieSeat(movieSeatBloc?.movieSeats?[2]);

      expect(
        movieSeatBloc?.movieSeats,
        getMockMovieSeats().expand((seats) => seats).toList(),
      );
      expect(movieSeatBloc?.selectedSeats, []);
      expect(movieSeatBloc?.totalPrice, 0);
    });
  });
}
