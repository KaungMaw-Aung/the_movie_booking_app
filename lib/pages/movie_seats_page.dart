import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/utils/constants.dart';
import 'package:the_movie_booking_app/viewitems/movie_seat_item_view.dart';
import 'package:the_movie_booking_app/widgets/dotted_line_section_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

import 'movie_snack_page.dart';

class MovieSeatsPage extends StatefulWidget {
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
  State<MovieSeatsPage> createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {
  /// state variables
  List<MovieSeatVO>? movieSeats;
  int? countInARow;
  int tickets = 0;
  List<String> seats = [];
  double totalPrice = 0;

  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  @override
  void initState() {
    movieBookingModel
        .getCinemaSeatingPlan(widget.timeslotId, widget.date)
        .then((value) {
      setState(() {
        movieSeats = value?[0] as List<MovieSeatVO>;
        countInARow = value?[1] as int;
      });
    }).catchError((error) => debugPrint(error.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.chevron_left),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              MovieNameTimeAndCinemaSectionView(
                movieDate: widget.date,
                cinema: widget.cinema,
                movieTime: widget.movieTime,
                movieTitle: widget.movieTitle,
              ),
              const SizedBox(height: MARGIN_LARGE),
              MovieSeatsSectionView(
                movieSeats: movieSeats,
                countInARow: countInARow,
                onTapMovieSeat: (seat) {
                  if (seat?.type == SEAT_TYPE_AVAILABLE) {
                    List<MovieSeatVO>? temp = movieSeats;
                    temp?.forEach((each) {
                      if (each.id == seat?.id && each.symbol == seat?.symbol) {
                        each.isSelected =
                            (seat?.isSelected == false) ? true : false;
                      }
                    });

                    if (seat?.isSelected == true) {
                      seats.add(seat?.seatName ?? "");
                      totalPrice += seat?.price ?? 0;
                    } else {
                      seats.remove(seat?.seatName ?? "");
                      totalPrice -= seat?.price ?? 0;
                    }

                    setState(() {
                      movieSeats = temp;
                    });
                  }
                },
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
              NumberOfSeatAndTicketSectionView(
                tickets: seats,
              ),
              const SizedBox(
                height: MARGIN_XLARGE,
              ),
              PrimaryButtonView(
                "Buy ticket for \$ $totalPrice",
                () => _navigateToMovieSnackPage(
                  context,
                  totalPrice,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieSnackPage(
      BuildContext context, double ticketsPrice) {
    if (ticketsPrice > 0.0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieSnackPage(
            ticketsPrice: ticketsPrice,
            cinemaId: widget.cinemaId,
            row: movieSeats
                    ?.where((each) => each.isSelected == true)
                    .map((seat) => seat.symbol)
                    .toSet()
                    .join(", ") ??
                "",
            movieId: widget.movieId,
            seatNumbers: movieSeats
                    ?.where((each) => each.isSelected == true)
                    .map((seat) => seat.seatName)
                    .join(", ") ??
                "",
            cinemaDayTimeslotId: widget.timeslotId,
            bookingDate: widget.date,
            moviePosterUrl: widget.moviePosterUrl,
            movieTitle: widget.movieTitle,
            cinema: widget.cinema,
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
  final List<MovieSeatVO>? movieSeats;
  final int? countInARow;
  final Function(MovieSeatVO?) onTapMovieSeat;

  MovieSeatsSectionView({
    required this.movieSeats,
    required this.countInARow,
    required this.onTapMovieSeat,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: movieSeats?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: countInARow ?? 1,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return MovieSeatItemView(
          movieSeat: movieSeats?[index],
          onTapMovieSeat: onTapMovieSeat,
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
