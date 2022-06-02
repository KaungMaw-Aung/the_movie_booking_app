import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/movie_details_bloc.dart';

import '../data.models/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Movie Details Bloc Test", () {
    MovieDetailsBloc? movieDetailsBloc;

    setUp(() {
      movieDetailsBloc = MovieDetailsBloc(634649, MovieBookingModelImplMock());
    });

    test("Get Movie Details Test", () {
      expect(movieDetailsBloc?.movie, getMockMovie());
    });

    test("Get Movie Casts Test", () {
      expect(
        movieDetailsBloc?.casts,
        getMockCasts()
            .where((element) => element.movieIds?.contains(634649) ?? false)
            .toList(),
      );
    });

  });
}
