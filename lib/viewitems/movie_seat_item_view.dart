import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/utils/constants.dart';

class MovieSeatItemView extends StatelessWidget {
  final MovieSeatVO? movieSeat;
  final Function(MovieSeatVO?) onTapMovieSeat;

  const MovieSeatItemView({
    Key? key,
    required this.movieSeat,
    required this.onTapMovieSeat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapMovieSeat(movieSeat);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        decoration: BoxDecoration(
          color: _getSeatColor(movieSeat),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(MARGIN_MEDIUM),
            topRight: Radius.circular(MARGIN_MEDIUM),
          ),
        ),
        child: Center(
          child: Text(
            _getMovieSeatText(movieSeat),
            style: TextStyle(
              color: (movieSeat?.type == SEAT_TYPE_TEXT) ? Colors.black : Colors.white,
              fontSize: TEXT_SMALL,
            ),
          ),
        ),
      ),
    );
  }

  Color _getSeatColor(MovieSeatVO? movieSeat) {
    if (movieSeat?.isMovieSeatAvailable() == true && movieSeat?.isSelected == false) {
      return MOVIE_SEAT_AVAILABLE_COLOR;
    } else if (movieSeat?.isMovieSeatTaken() == true) {
      return MOVIE_SEAT_TAKEN_COLOR;
    } else if (movieSeat?.isMovieSeatAvailable() == true && movieSeat?.isSelected == true) {
      return PRIMARY_COLOR;
    } else {
      return Colors.white;
    }
  }

  String _getMovieSeatText(MovieSeatVO? seat) {
    var result = "";
    if (seat?.type == SEAT_TYPE_TEXT) {
      result = seat?.symbol ?? "";
    } else if (movieSeat?.isMovieSeatAvailable() == true && movieSeat?.isSelected == true) {
      result = seat?.seatName ?? "";
    }

    return result;
  }

}
