import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/home_bloc.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/pages/movie_details_page.dart';
import 'package:the_movie_booking_app/pages/welcome_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/utils/utils.dart';
import 'package:the_movie_booking_app/viewitems/movie_view.dart';
import 'package:the_movie_booking_app/widgets/heading_text_view.dart';
import 'package:the_movie_booking_app/widgets/sub_heading_text_view.dart';

class HomePage extends StatelessWidget {
  List<String> menuItems = [
    "Promotion code",
    "Select a language",
    "Term of services",
    "Help",
    "Rate us"
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(
                  MARGIN_CARD_MEDIUM_2,
                ),
                child: Image.asset(
                  'assets/images/menu_icon.png',
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(
                MARGIN_MEDIUM,
              ),
              child: Image.asset(
                'assets/images/search_icon.png',
              ),
            )
          ],
        ),
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Drawer(
            child: Container(
              color: PRIMARY_COLOR,
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Column(
                children: [
                  const SizedBox(
                    height: DRAWER_HEADER_TOP_MARGIN,
                  ),
                  DrawerHeaderSectionView(),
                  const SizedBox(
                    height: MARGIN_XXLARGE,
                  ),
                  Column(
                    children: menuItems
                        .map(
                          (item) => Container(
                            margin: const EdgeInsets.only(top: MARGIN_MEDIUM_2),
                            child: ListTile(
                              leading: const Icon(
                                Icons.help,
                                size: MARGIN_XLARGE,
                                color: Colors.white,
                              ),
                              title: Text(item,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: TEXT_REGULAR_3X,
                                  )),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const Spacer(),
                  Builder(
                    builder: (BuildContext context) => ListTile(
                      onTap: () {
                        HomeBloc bloc = Provider.of(context, listen: false);
                        bloc.logout().then((message) {
                          showToast(message ?? "logout succeed");
                          _navigateToWelcomePage(context);
                        }).catchError((error) => debugPrint(error.toString()));
                      },
                      leading: const Icon(
                        Icons.logout,
                        size: MARGIN_XLARGE,
                        color: Colors.white,
                      ),
                      title: const Text(
                        LOGOUT_TEXT,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: TEXT_REGULAR_3X,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LARGE,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: MARGIN_CARD_MEDIUM_2,
              ),
              Selector<HomeBloc, String?>(
                selector: (context, bloc) => bloc.name,
                builder: (context, name, child) =>
                    UserProfileSectionView(name: name ?? ""),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              Selector<HomeBloc, List<MovieVO>?>(
                selector: (context, bloc) => bloc.nowPlayingMovies,
                builder: (context, nowPlayingMovies, child) =>
                    MovieListSectionView(
                  "Now Showing",
                  (int movieId) => _navigateToMovieDetailPage(context, movieId),
                  movies: nowPlayingMovies,
                ),
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Selector<HomeBloc, List<MovieVO>?>(
                selector: (context, bloc) => bloc.comingSoonMovies,
                builder: (context, comingSoonMovies, child) =>
                    MovieListSectionView(
                  "Coming Soon",
                  (int movieId) => _navigateToMovieDetailPage(context, movieId),
                  movies: comingSoonMovies,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToMovieDetailPage(BuildContext context, int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          movieId: movieId,
        ),
      ),
    );
  }

  _navigateToWelcomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomePage(),
      ),
    );
  }
}

class DrawerHeaderSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularAvaterImageView(),
          const SizedBox(
            width: MARGIN_MEDIUM_2,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<HomeBloc, String?>(
                  selector: (context, bloc) => bloc.name,
                  builder: (context, name, child) => Text(
                    name ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: MARGIN_SMALL,
                ),
                Flexible(
                  child: Selector<HomeBloc, String?>(
                    selector: (context, bloc) => bloc.email,
                    builder: (context, email, child) => Text(
                      email ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM,
                ),
                const Text(
                  EDIT_BUTTON_TEXT,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MovieListSectionView extends StatelessWidget {
  final String sectionTitle;
  final Function(int) onTapMovieItem;
  final List<MovieVO>? movies;

  MovieListSectionView(this.sectionTitle, this.onTapMovieItem,
      {required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: MARGIN_MEDIUM_2,
          ),
          child: SubHeadingTextView(
            sectionTitle,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        Container(
          height: HORIZONTAL_MOVIE_LIST_HEIGHT,
          child: HorizontalMovieListView(
            onTapMovieItem,
            movies: movies,
          ),
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int) onTabMovieItem;
  final List<MovieVO>? movies;

  HorizontalMovieListView(this.onTabMovieItem, {required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: MARGIN_MEDIUM_3,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: movies?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return MovieView(
          onTabMovieItem,
          movie: movies?[index],
        );
      },
    );
  }
}

class UserProfileSectionView extends StatelessWidget {
  final String name;

  UserProfileSectionView({required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        CircularAvaterImageView(),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        HeadingTextView(
          title: "Hi $name!",
        ),
      ],
    );
  }
}

class CircularAvaterImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: CIRCULAR_PROFILE_IMAGE_SIZE,
      height: CIRCULAR_PROFILE_IMAGE_SIZE,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://static.wikia.nocookie.net/gtawiki/images/9/9a/TommyVercetti-GTAVCDE.png/revision/latest?cb=20211111045208",
          ),
        ),
      ),
    );
  }
}
