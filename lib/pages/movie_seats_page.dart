import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/movie_seats_bloc.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/viewitems/movie_seat_item_view.dart';
import 'package:the_movie_booking_app/widgets/dotted_line_section_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

import 'movie_snack_page.dart';

class MovieSeatsPage extends StatelessWidget {
  final String date;
  final int timeslotId;
  final String movieTitle;
  final String movieTime;
  final String cinema;
  final int movieId;
  final int cinemaId;
  final String moviePosterUrl;

  MovieSeatsPage({
    required this.timeslotId,
    required this.date,
    required this.movieTitle,
    required this.movieTime,
    required this.cinema,
    required this.movieId,
    required this.cinemaId,
    required this.moviePosterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieSeatsBloc(timeslotId, date),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left),
          ),
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  MovieNameTimeAndCinemaSectionView(
                    movieDate: date,
                    cinema: cinema,
                    movieTime: movieTime,
                    movieTitle: movieTitle,
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<MovieSeatsBloc, List<MovieSeatVO>?>(
                    selector: (context, bloc) => bloc.movieSeats,
                    shouldRebuild: (oldValue, newValue) => oldValue != newValue,
                    builder: (context, seats, child) => MovieSeatsSectionView(
                      seats: seats,
                      onTapMovieSeat: (seat) {
                        MovieSeatsBloc bloc = Provider.of(context, listen: false);
                        bloc.onTapMovieSeat(seat);
                      },
                    ),
                  ),
                  const SizedBox(height: MARGIN_MEDIUM_2),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: MovieSeatGlossarySectionView(),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: DottedLineSectionView(),
                  ),
                  const SizedBox(height: MARGIN_LARGE),
                  Selector<MovieSeatsBloc, List<String>>(
                    selector: (context, bloc) => bloc.selectedSeats,
                    shouldRebuild: (oldValue, newValue) => oldValue != newValue,
                    builder: (context, selectedSeats, child) =>
                        NumberOfSeatAndTicketSectionView(
                          tickets: selectedSeats,
                        ),
                  ),
                  const SizedBox(
                    height: MARGIN_XLARGE,
                  ),
                  Selector<MovieSeatsBloc, double>(
                    selector: (context, bloc) => bloc.totalPrice,
                    builder: (context, totalPrice, child) => PrimaryButtonView(
                      "Buy ticket for \$ $totalPrice",
                          () => _navigateToMovieSnackPage(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMovieSnackPage(BuildContext context) {
    MovieSeatsBloc bloc = Provider.of(context, listen: false);
    if (bloc.totalPrice > 0.0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieSnackPage(
            ticketsPrice: bloc.totalPrice,
            cinemaId: cinemaId,
            row: bloc.movieSeats
                    ?.where((each) => each.isSelected == true)
                    .map((seat) => seat.symbol)
                    .toSet()
                    .join(", ") ??
                "",
            movieId: movieId,
            seatNumbers: bloc.selectedSeats.join(", "),
            cinemaDayTimeslotId: timeslotId,
            bookingDate: date,
            moviePosterUrl: moviePosterUrl,
            movieTitle: movieTitle,
            cinema: cinema,
          ),
        ),
      );
    }
  }
}

class NumberOfSeatAndTicketSectionView extends StatelessWidget {
  final List<String> tickets;

  NumberOfSeatAndTicketSectionView({required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: Column(
          children: [
            NumberOfTicketAndSeatView("Tickets", "${tickets.length}"),
            const SizedBox(
              height: MARGIN_MEDIUM,
            ),
            NumberOfTicketAndSeatView("Seats", tickets.join(", ")),
          ],
        ));
  }
}

class NumberOfTicketAndSeatView extends StatelessWidget {
  final String mTitle;
  final String mInfo;

  NumberOfTicketAndSeatView(this.mTitle, this.mInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          mTitle,
          style: const TextStyle(color: CINEMA_TEXT_COLOR),
        ),
        const Spacer(),
        Text(
          mInfo,
          style: const TextStyle(color: CINEMA_TEXT_COLOR),
        ),
      ],
    );
  }
}

class MovieSeatGlossarySectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                MovieSeatGlossaryView(MOVIE_SEAT_AVAILABLE_COLOR, "Available")),
        Expanded(
            child: MovieSeatGlossaryView(MOVIE_SEAT_TAKEN_COLOR, "Reserved")),
        Expanded(child: MovieSeatGlossaryView(PRIMARY_COLOR, "Your Selection")),
      ],
    );
  }
}

class MovieSeatGlossaryView extends StatelessWidget {
  final Color glossaryColor;
  final String glossaryText;

  MovieSeatGlossaryView(this.glossaryColor, this.glossaryText);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MARGIN_LARGE,
          height: MARGIN_LARGE,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: glossaryColor,
          ),
        ),
        const SizedBox(
          width: MARGIN_SMALL,
        ),
        Text(
          glossaryText,
          style: const TextStyle(
            color: CINEMA_TEXT_COLOR,
            fontSize: TEXT_REGULAR,
          ),
        )
      ],
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  final List<MovieSeatVO>? seats;
  final Function(MovieSeatVO?) onTapMovieSeat;

  MovieSeatsSectionView({
    required this.seats,
    required this.onTapMovieSeat,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<MovieSeatsBloc, int?>(
      selector: (context, bloc) => bloc.countInARow,
      builder: (context, seatCountInARow, child) {
        // if (selectedSeat != null) {
        //   seats?.forEach((each) {
        //     if (each.id == selectedSeat?.id &&
        //         each.symbol == selectedSeat?.symbol) {
        //       each.isSelected =
        //           (selectedSeat?.isSelected == false) ? true : false;
        //     }
        //   });
        // }

        return GridView.builder(
          itemCount: seats?.length ?? 0,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: seatCountInARow ?? 1,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return MovieSeatItemView(
              key: Key(("seat_$index")),
              movieSeat: seats?[index],
              onTapMovieSeat: onTapMovieSeat,
            );
          },
        );
      },
    );
  }
}

class MovieNameTimeAndCinemaSectionView extends StatelessWidget {
  final String movieTitle;
  final String cinema;
  final String movieDate;
  final String movieTime;

  MovieNameTimeAndCinemaSectionView({
    required this.movieTitle,
    required this.cinema,
    required this.movieDate,
    required this.movieTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          movieTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          cinema,
          style: const TextStyle(
            color: CINEMA_TEXT_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          "$movieDate, $movieTime",
          style: const TextStyle(
            color: MOVIE_TIME_TEXT_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}
