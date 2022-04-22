import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class MovieView extends StatelessWidget {

  final Function(int) onTapMovieItem;
  final MovieVO? movie;

  MovieView(this.onTapMovieItem, {required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapMovieItem(movie?.id ?? -1),
      child: Container(
        width: MOVIE_LIST_IMAGE_WIDTH,
        margin: const EdgeInsets.only(
          right: MARGIN_MEDIUM_3,
        ),
        child: Column(
          children: [
            MovieImageView(url: movie?.posterPath,),
            const SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            GestureDetector(
              onTap: () => onTapMovieItem(movie?.id ?? -1),
              child: Text(
                movie?.title ?? "",
                maxLines: 1,
                style: const TextStyle(
                  fontSize: TEXT_SMALL_2,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: MARGIN_SMALL,
            ),
            Row(
              children: [
                const Spacer(),
                MovieListItemGenreTimeTextView("Mystery/Adventure"),
                MovieListItemGenreTimeTextView(" - "),
                MovieListItemGenreTimeTextView("1h 45m"),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MovieListItemGenreTimeTextView extends StatelessWidget {

  final String text;

  MovieListItemGenreTimeTextView(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: TEXT_SMALL,
        color: SECONDARY_WELCOME_TEXT_COLOR,
      ),
    );
  }
}

class MovieImageView extends StatelessWidget {

  final String? url;

  MovieImageView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_LIST_IMAGE_HEIGHT,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(
          Radius.circular(MARGIN_CARD_MEDIUM_2),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "$IMAGE_BASE_URL${url ?? ""}",
          ),
        ),
      ),
    );
  }
}
