import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/ticket_bloc.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/widgets/dotted_line_section_view.dart';

class TicketPage extends StatelessWidget {
  final VoucherVO? voucher;
  final String moviePosterUrl;
  final String movieTitle;
  final String cinema;

  TicketPage({
    required this.voucher,
    required this.moviePosterUrl,
    required this.movieTitle,
    required this.cinema,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TicketBloc(
        voucher: voucher,
        moviePosterUrl: moviePosterUrl,
        movieTitle: movieTitle,
        cinema: cinema,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => _navigateToHome(context),
            child: const Icon(Icons.close),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                TicketHeaderView(),
                const SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
                Selector<TicketBloc, VoucherVO?>(
                  selector: (context, bloc) => bloc.voucher,
                  builder: (context, voucher, child) {
                    return TicketSectionView(
                        voucher: voucher
                    );
                  },
                ),
                const SizedBox(
                  height: MARGIN_MEDIUM_2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }
}

class TicketSectionView extends StatelessWidget {
  final VoucherVO? voucher;

  TicketSectionView({required this.voucher});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
      color: Colors.black,
      elevation: MOVIE_TICKET_ELEVATION,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Selector<TicketBloc, String>(
              selector: (context, bloc) => bloc.moviePosterUrl,
              builder: (context, posterUrl, child) {
                return TicketMoviePosterView(
                  moviePosterUrl: posterUrl,
                );
              },
            ),
            const SizedBox(
              height: MARGIN_MEDIUM,
            ),
            Selector<TicketBloc, String>(
              selector: (context, bloc) => bloc.movieTitle,
              builder: (context, movieTitle, child) {
                return Padding(
                  padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
                  child: MovieTitleTextView(
                    movieTitle: movieTitle,
                  ),
                );
              },
            ),
            // Text(),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            DottedLineSectionView(),
            const SizedBox(height: MARGIN_LARGE),
            TicketInfoView(BOOKING_NUMBER, voucher?.bookingNo),
            const SizedBox(height: MARGIN_LARGE),
            TicketInfoView(SHOWTIME_DATE,
                "${voucher?.timeslot?.movieTime ?? ""} - ${voucher?.bookingDate ?? ""}"),
            const SizedBox(height: MARGIN_LARGE),
            Selector<TicketBloc, String>(
              selector: (context, bloc) => bloc.cinema,
              builder: (context, cinema, child) {
                return TicketInfoView(THEATER, cinema);
              },
            ),
            const SizedBox(height: MARGIN_LARGE),
            TicketInfoView(SCREEN, "2"),
            const SizedBox(height: MARGIN_LARGE),
            TicketInfoView(ROW, voucher?.row),
            const SizedBox(height: MARGIN_LARGE),
            TicketInfoView(SEATS, voucher?.seat),
            const SizedBox(height: MARGIN_LARGE),
            TicketInfoView(PRICE, "${voucher?.total ?? 0.0}"),
            const SizedBox(height: MARGIN_LARGE),
            DottedLineSectionView(),
            const SizedBox(height: MARGIN_MEDIUM_2),
            Container(
              alignment: Alignment.center,
              child: BarcodeWidget(
                barcode: Barcode.code128(),
                data: voucher?.qrCode ?? 'Hello Flutter',
                height: BARCODE_HEIGHT,
                width: BARCODE_WIDTH,
              ),
            ),
            const SizedBox(height: MARGIN_MEDIUM_2),
          ],
        ),
      ),
    );
  }
}

class TicketInfoView extends StatelessWidget {
  final String tTitle;
  final String? tInfo;

  TicketInfoView(this.tTitle, this.tInfo);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
        Text(
          tTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        const Spacer(),
        Text(tInfo ?? ""),
        const SizedBox(
          width: MARGIN_MEDIUM_2,
        ),
      ],
    );
  }
}

class MovieTitleTextView extends StatelessWidget {
  final String movieTitle;

  MovieTitleTextView({required this.movieTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movieTitle,
          style: const TextStyle(
              fontSize: TEXT_REGULAR_3X, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        const Text(
          "105m - IMAX",
          style:
              TextStyle(fontSize: TEXT_REGULAR_2X, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}

class TicketMoviePosterView extends StatelessWidget {
  final String moviePosterUrl;

  TicketMoviePosterView({required this.moviePosterUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TICKET_MOVIE_POSTER_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(MARGIN_MEDIUM_2),
          topRight: Radius.circular(MARGIN_MEDIUM_2),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "$IMAGE_BASE_URL$moviePosterUrl",
          ),
        ),
      ),
    );
  }
}

class TicketHeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          AWESOME_TEXT,
          style: TextStyle(
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          THIS_IS_YOUR_TICKET,
          style: TextStyle(
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
