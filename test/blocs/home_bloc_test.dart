import 'package:flutter_test/flutter_test.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';

import '../data.models/movie_booking_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  group("Home Bloc Test", () {
    HomeBloc? homeBloc;

    setUp(() {
      homeBloc = HomeBloc(MovieBookingModelImplMock());
    });

    test("Get User Data Test", () {
      expect(homeBloc?.name, getMockUser().name);
      expect(homeBloc?.email, getMockUser().email);
    });

    test("Get Now Playing Movies Test", () {
      expect(
        homeBloc?.nowPlayingMovies,
        getMockMovies().where((element) => element.isNowPlaying).toList(),
      );
    });

    test("Get Coming Soon Movies Test", () {
      expect(
        homeBloc?.comingSoonMovies,
        getMockMovies().where((element) => element.isComingSoon).toList(),
      );
    });

  });
}
