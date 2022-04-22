import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/choose_time_bloc.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/date_vo.dart';
import 'package:the_movie_booking_app/pages/movie_seats_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

class MovieChooseTimePage extends StatelessWidget {
  final int? movieId;
  final String? movieTitle;
  final String moviePosterUrl;

  MovieChooseTimePage({
    required this.movieId,
    required this.movieTitle,
    required this.moviePosterUrl,
  });

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
      child: ChangeNotifierProvider<ChooseTimeBloc>(
        create: (context) => ChooseTimeBloc(movieId),
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
                Selector<ChooseTimeBloc, List<DateVO>?>(
                    selector: (context, bloc) => bloc.dates,
                    shouldRebuild: (oldValue, newValue) => oldValue != newValue,
                    builder: (context, dates, child) {
                      return MovieChooseDateView(
                        dates: dates,
                        onTapDate: (index) {
                          ChooseTimeBloc bloc =
                              Provider.of(context, listen: false);
                          bloc.onTapDate(index);
                        },
                      );
                    }),
                Selector<ChooseTimeBloc, List<CinemaVO>?>(
                  selector: (context, bloc) => bloc.cinemas,
                  shouldRebuild: (oldValue, newValue) => oldValue != newValue,
                  builder: (context, cinemas, child) =>
                      ChooseItemGridSectionView(
                    cinemas: cinemas,
                    onTapTimeslot: (timeslotId, movieTime) {
                      ChooseTimeBloc bloc = Provider.of(context, listen: false);
                      bloc.onTapTimeslot(timeslotId, movieTime);
                    },
                  ),
                ),
                const SizedBox(
                  height: MARGIN_LARGE,
                ),
                Builder(
                  builder: (context) => PrimaryButtonView(
                    "Next",
                    () {
                      _navigateToMovieSeatsPage(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToMovieSeatsPage(BuildContext context) {
    ChooseTimeBloc bloc = Provider.of(context, listen: false);
    if (bloc.selectedTimeslotId != null &&
        bloc.selectedDate != null &&
        bloc.movieTime != null &&
        bloc.cinema != null &&
        bloc.cinemaId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MovieSeatsPage(
            timeslotId: bloc.selectedTimeslotId!,
            date: bloc.selectedDate!,
            movieTitle: movieTitle ?? "",
            movieTime: bloc.movieTime!,
            cinema: bloc.cinema!,
            movieId: movieId ?? -1,
            cinemaId: bloc.cinemaId!,
            moviePosterUrl: moviePosterUrl,
          ),
        ),
      );
    }
  }
}

class ChooseItemGridSectionView extends StatelessWidget {
  final List<CinemaVO>? cinemas;
  final Function(int, String) onTapTimeslot;

  ChooseItemGridSectionView({
    required this.cinemas,
    required this.onTapTimeslot,
  });

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
  final List<DateVO>? dates;
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
        itemCount: dates?.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTapDate(index),
            child: DateView(
              key: Key("date$index"),
              dates: dates,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

class DateView extends StatelessWidget {
  const DateView({
    Key? key,
    required this.dates,
    required this.index,
  }) : super(key: key);

  final List<DateVO>? dates;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          dates?[index].day ?? "",
          style: TextStyle(
            color:
                dates?[index].isSelected == true ? Colors.white : Colors.grey,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          dates?[index].daysOfMonth ?? "",
          style: TextStyle(
            color:
                dates?[index].isSelected == true ? Colors.white : Colors.grey,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
      ],
    );
  }
}
