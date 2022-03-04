import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/pages/movie_seats_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

class MovieChooseTimePage extends StatefulWidget {
  final int? movieId;
  final String? movieTitle;
  final String moviePosterUrl;

  MovieChooseTimePage({
    required this.movieId,
    required this.movieTitle,
    required this.moviePosterUrl,
  });

  @override
  State<MovieChooseTimePage> createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
  /// state variables
  List<DateVO>? dates;
  List<CinemaVO>? cinemas;

  String? selectedDate;
  int? selectedTimeslotId;
  String? movieTime;
  String? cinema;
  int? cinemaId;

  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  @override
  void initState() {
    movieBookingModel.getDates().then((dates) {
      this.dates = dates;
      selectedDate = dates?.first.date;

      // _getCinemaDayTimeslot(
      //   widget.movieId ?? -1,
      //   dates?.first.date ?? "",
      // );

      _getCinemaDayTimeslotFromDatabase(
          widget.movieId ?? -1, dates?.first.date ?? "");
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    dates?.forEach((date) {
      date.isSelected = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: PRIMARY_COLOR,
              iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(
                    color: Colors.white,
                    size: MARGIN_XLARGE,
                  ),
            ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MovieChooseDateView(
                dates: dates ?? [],
                onTapDate: (index) {
                  setState(() {
                    dates?.forEach((date) {
                      date.isSelected = false;
                    });
                    dates?[index].isSelected = true;
                  });
                  // _getCinemaDayTimeslot(
                  //   widget.movieId ?? -1,
                  //   dates?[index].date ?? "",
                  // );
                  _getCinemaDayTimeslotFromDatabase(
                    widget.movieId ?? -1,
                    dates?[index].date ?? "",
                  );
                  selectedDate = dates?[index].date;
                },
              ),
              ChooseItemGridSectionView(
                cinemas: cinemas,
                onTapTimeslot: (timeslotId, movieTime) {
                  List<CinemaVO> selectedCinemas = cinemas?.map((each) {
                        each.timeslots?.forEach((element) {
                          if (element.cinemaTimeslotId == timeslotId) {
                            element.isSelected = true;
                          } else {
                            element.isSelected = false;
                          }
                        });
                        return each;
                      }).toList() ??
                      [];
                  setState(() {
                    cinemas = selectedCinemas;
                  });
                  selectedTimeslotId = timeslotId;
                  this.movieTime = movieTime;
                  cinemas?.forEach((cinema) {
                    cinema.timeslots?.forEach((element) {
                      if (element.cinemaTimeslotId == timeslotId) {
                        this.cinema = cinema.cinema;
                        cinemaId = cinema.cinemaId;
                      }
                    });
                  });
                },
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              PrimaryButtonView(
                "Next",
                () {
                  _navigateToMovieSeatsPage(
                    context,
                    selectedDate,
                    selectedTimeslotId,
                    widget.movieTitle ?? "",
                    movieTime ?? "",
                    cinema ?? "",
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToMovieSeatsPage(BuildContext context, String? date,
      int? timeslotId, String movieTitle, String movieTime, String cinema) {
    if (date != null && timeslotId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieSeatsPage(
            timeslotId: selectedTimeslotId ?? -1,
            date: selectedDate ?? "",
            movieTitle: movieTitle,
            movieTime: movieTime,
            cinema: cinema,
            movieId: widget.movieId ?? -1,
            cinemaId: cinemaId ?? -1,
            moviePosterUrl: widget.moviePosterUrl,
          ),
        ),
      );
    }
  }

  // void _getCinemaDayTimeslot(int movieId, String date) {
  //   movieBookingModel.getCinemaDayTimeslot(movieId, date).then((cinemas) {
  //     setState(() {
  //       this.cinemas = cinemas;
  //     });
  //   }).catchError((error) => debugPrint(error.toString()));
  // }

  void _getCinemaDayTimeslotFromDatabase(int movieId, String date) {
    movieBookingModel.getCinemasFromDatabase(movieId, date).listen((cinemas) {
      setState(() {
        this.cinemas = cinemas;
      });
    }).onError((error) => debugPrint(error.toString()));
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<CinemaVO>? cinemas;
  final Function(int, String) onTapTimeslot;

  ChooseItemGridSectionView(
      {required this.cinemas, required this.onTapTimeslot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        left: MARGIN_MEDIUM_2,
        right: MARGIN_MEDIUM_2,
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: cinemas
                  ?.map((cinema) => ChooseItemGridView(
                        cinema: cinema,
                        onTapTimeslot: onTapTimeslot,
                      ))
                  .toList() ??
              []),
    );
  }
}

class ChooseItemGridView extends StatelessWidget {
  final CinemaVO? cinema;
  final Function(int, String) onTapTimeslot;

  ChooseItemGridView({required this.cinema, required this.onTapTimeslot});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cinema?.cinema ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        GridView.builder(
            itemCount: cinema?.timeslots?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onTapTimeslot(
                  cinema?.timeslots?[index].cinemaTimeslotId ?? -1,
                  cinema?.timeslots?[index].movieTime ?? "",
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: MARGIN_MEDIUM_2,
                      right: MARGIN_MEDIUM_2,
                      top: MARGIN_MEDIUM),
                  decoration: BoxDecoration(
                    color: (cinema?.timeslots?[index].isSelected == true)
                        ? PRIMARY_COLOR
                        : Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
                  ),
                  child: Center(
                    child: Text(
                      cinema?.timeslots?[index].movieTime ?? "",
                      style: TextStyle(
                        color: (cinema?.timeslots?[index].isSelected == true)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          height: MARGIN_LARGE,
        ),
      ],
    );
  }
}

class MovieChooseDateView extends StatelessWidget {
  final List<DateVO> dates;
  final Function(int) onTapDate;

  MovieChooseDateView({required this.dates, required this.onTapDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_TIME_DATE_LIST_HEIGHT,
      color: PRIMARY_COLOR,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(width: MARGIN_MEDIUM_2);
        },
        itemCount: dates.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTapDate(index),
            child: Column(
              children: [
                Text(
                  dates[index].day,
                  style: TextStyle(
                    color: dates[index].isSelected ? Colors.white : Colors.grey,
                    fontSize: TEXT_REGULAR_3X,
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                Text(
                  dates[index].daysOfMonth,
                  style: TextStyle(
                    color: dates[index].isSelected ? Colors.white : Colors.grey,
                    fontSize: TEXT_REGULAR_3X,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
