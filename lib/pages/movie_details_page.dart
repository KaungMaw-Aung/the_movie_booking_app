import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/movie_details_bloc.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/viewitems/cast_view.dart';
import 'package:the_movie_booking_app/widgets/heading_text_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';
import 'package:the_movie_booking_app/widgets/sub_heading_text_view.dart';

import 'movie_choose_time_page.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;

  MovieDetailsPage({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieDetailsBloc(movieId),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: CustomScrollView(
                slivers: [
                  Selector<MovieDetailsBloc, String?>(
                    selector: (context, bloc) => bloc.moviePosterUrl,
                    builder: (context, posterUrl, child) =>
                        MovieDetailsSliverAppBarView(
                      () => _backToHomePage(context),
                      posterPath: posterUrl,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        Selector<MovieDetailsBloc, MovieVO?>(
                          selector: (context, bloc) => bloc.movie,
                          builder: (context, movie, child) =>
                              MovieDetailsInfoSectionView(movie: movie),
                        ),
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        Selector<MovieDetailsBloc, MovieVO?>(
                          selector: (context, bloc) => bloc.movie,
                          builder: (context, movie, child) =>
                              MovieDetailsPlotSectionView(
                            overview: movie?.overview,
                          ),
                        ),
                        const SizedBox(
                          height: MARGIN_LARGE,
                        ),
                        Selector<MovieDetailsBloc, List<CastVO>?>(
                          selector: (context, bloc) => bloc.casts,
                          builder: (context, casts, child) =>
                              MovieDetailsCastSectionView(
                            casts: casts,
                          ),
                        ),
                        const SizedBox(
                          height: MOVIE_DETAIL_SCREEN_MARGIN_BOTTOM,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM_3),
                child: Builder(
                  builder: (context) => PrimaryButtonView(
                    GET_YOUR_TICKET,
                    () => _navigateToMovieChooseTimePage(context),
                    isElevated: true,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _navigateToMovieChooseTimePage(BuildContext context) {
    MovieDetailsBloc bloc = Provider.of(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieChooseTimePage(
          movieId: bloc.movie?.id ?? -1,
          movieTitle: bloc.movie?.title ?? "",
          moviePosterUrl: bloc.moviePosterUrl ?? "",
        ),
      ),
    );
  }

  _backToHomePage(BuildContext context) {
    Navigator.pop(context);
  }
}

class MovieDetailsCastSectionView extends StatelessWidget {
  final List<CastVO>? casts;

  MovieDetailsCastSectionView({required this.casts});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: SubHeadingTextView("Cast"),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: MOVIE_DETAILS_CAST_SIZE,
          child: ListView(
            padding: const EdgeInsets.only(
              left: MARGIN_MEDIUM_2,
            ),
            scrollDirection: Axis.horizontal,
            children: casts
                    ?.map((cast) => CastView(castImgUrl: cast.profilePath))
                    .toList() ??
                [],
          ),
        )
      ],
    );
  }
}

class MovieDetailsPlotSectionView extends StatelessWidget {
  final String? overview;

  MovieDetailsPlotSectionView({required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: SubHeadingTextView("Plot Summary"),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: Text(
            overview ?? "",
            style: const TextStyle(
              height: MOVIE_DETAILS_PLOT_LINE_HEIGHT,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieDetailsInfoSectionView extends StatelessWidget {
  final MovieVO? movie;

  MovieDetailsInfoSectionView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: HeadingTextView(
            title: movie?.title,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        MovieDurationAndRatingView(
          duration: movie?.getDuration(),
          rating: movie?.voteAverage,
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Wrap(
          children: movie?.genres
                  ?.map((genre) => GenreChipView(genre.name))
                  .toList() ??
              [],
        ),
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String? label;

  GenreChipView(this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Chip(
          padding: const EdgeInsets.symmetric(
              horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_CARD_MEDIUM_2),
          backgroundColor: Colors.white,
          side:
              const BorderSide(color: SECONDARY_WELCOME_TEXT_COLOR, width: 0.5),
          label: Text(
            label ?? "",
          ),
        ),
      ],
    );
  }
}

class MovieDurationAndRatingView extends StatelessWidget {
  final String? duration;
  final double? rating;

  MovieDurationAndRatingView({required this.duration, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Text(
          duration ?? "",
          style: const TextStyle(
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        RatingView(),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Text(
          "IMDb ${rating ?? 0.0}",
          style: const TextStyle(
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class RatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5.0,
      itemBuilder: (BuildContext context, int index) => const Icon(
        Icons.star,
        color: RATING_STAR_COLOR,
        size: MARGIN_LARGE,
      ),
      itemSize: MARGIN_LARGE,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

class MovieDetailsSliverAppBarView extends StatelessWidget {
  final Function onTapBackButton;
  final String? posterPath;

  MovieDetailsSliverAppBarView(this.onTapBackButton,
      {required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: MediaQuery.of(context).size.height * 2 / 5,
      backgroundColor: HOME_SCREEN_BACKGROUND_COLOR,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: MovieDetailsImageView(
                    url: posterPath,
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: MOVIE_DETAILS_PLAY_BUTTON_SIZE,
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: MARGIN_XXLARGE),
                    child: GestureDetector(
                      onTap: () => onTapBackButton(),
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: MARGIN_XXLARGE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MARGIN_LARGE,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MARGIN_LARGE),
                  topRight: Radius.circular(MARGIN_LARGE),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MovieDetailsImageView extends StatelessWidget {
  final String? url;

  MovieDetailsImageView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL${url ?? ""}",
      fit: BoxFit.cover,
    );
  }
}
