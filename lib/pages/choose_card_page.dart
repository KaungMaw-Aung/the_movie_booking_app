import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/choose_card_bloc.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_req_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/pages/add_new_card_page.dart';
import 'package:the_movie_booking_app/pages/ticket_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

class ChooseCardPage extends StatelessWidget {
  final String totalAmount;
  final int cinemaDayTimeslotId;
  final String row;
  final String seatNumbers;
  final String bookingDate;
  final int movieId;
  final int cinemaId;
  final List<SnackReqVO> snacks;
  final String moviePosterUrl;
  final String movieTitle;
  final String cinema;

  ChooseCardPage({
    required this.totalAmount,
    required this.cinemaDayTimeslotId,
    required this.row,
    required this.seatNumbers,
    required this.bookingDate,
    required this.movieId,
    required this.cinemaId,
    required this.snacks,
    required this.moviePosterUrl,
    required this.movieTitle,
    required this.cinema,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChooseCardBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              child: PaymentAmountSectionView(
                paymentAmount: totalAmount,
              ),
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            Selector<ChooseCardBloc, List<CardVO>?>(
              selector: (context, bloc) => bloc.cards,
              builder: (context, cards, child) {
                return Container(
                  height: CARD_CAROUSEL_HEIGHT,
                  child: (cards?.isNotEmpty == true)
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: CARD_CAROUSEL_HEIGHT,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, _) {
                              ChooseCardBloc bloc =
                                  Provider.of(context, listen: false);
                              bloc.onCardChange(index);
                            },
                          ),
                          items: cards
                                  ?.map((each) => CardView(card: each))
                                  .toList().reversed.toList() ??
                              [],
                        )
                      : const Center(
                          child: Text("You currently have no cards added.")),
                );
              },
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            Padding(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              child: GestureDetector(
                onTap: () => _navigateToAddNewCardPage(context),
                child: AddNewCardButtonView(),
              ),
            ),
            const Spacer(),
            Builder(
              builder: (context) => PrimaryButtonView(PURCHASE, () {
                ChooseCardBloc bloc = Provider.of(context, listen: false);
                bloc
                    .checkout(
                  cinemaDayTimeslotId,
                  row,
                  seatNumbers,
                  bookingDate,
                  double.parse(totalAmount),
                  movieId,
                  bloc.getSelectedCardId(),
                  cinemaId,
                  snacks,
                )
                    .then((voucher) {
                  _navigateToTicketPage(context, voucher);
                }).catchError((error) {
                  debugPrint(error.toString());
                });
              }),
            ),
            const SizedBox(
              height: MARGIN_MEDIUM_2,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAddNewCardPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewCardPage(),
      ),
    );
  }

  void _navigateToTicketPage(BuildContext context, VoucherVO? voucher) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketPage(
          voucher: voucher,
          moviePosterUrl: moviePosterUrl,
          cinema: cinema,
          movieTitle: movieTitle,
        ),
      ),
    );
  }
}

class AddNewCardButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.add_circle,
          color: ADD_NEW_CARD_BUTTON_COLOR,
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Text(
          ADD_NEW_CARD_TEXT,
          style: TextStyle(
            color: ADD_NEW_CARD_BUTTON_COLOR,
            fontWeight: FontWeight.w700,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class CardView extends StatelessWidget {
  final CardVO? card;

  CardView({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
        gradient: const LinearGradient(
          colors: [
            CARD_GRADIENT_START_COLOR,
            CARD_GRADIENT_END_COLOR,
          ],
        ),
      ),
      child: Column(
        children: [
          VisaLogoAndMoreButtonView(),
          const SizedBox(
            height: MARGIN_MEDIUM_3,
          ),
          Text(
            card?.cardNumber ?? "****  ****  ****  8014",
            style: const TextStyle(
              color: Colors.white,
              fontSize: TEXT_HEADING_1X,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          CardHolderAndExpiresSectionView(
            holder: card?.cardHolder,
            expDate: card?.expirationDate,
          )
        ],
      ),
    );
  }
}

class CardHolderAndExpiresSectionView extends StatelessWidget {
  final String? holder;
  final String? expDate;

  CardHolderAndExpiresSectionView({
    required this.holder,
    required this.expDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardHolderAndExpiresView(CARD_HOLDER_TEXT, holder ?? ""),
        const Spacer(),
        CardHolderAndExpiresView(CARD_EXPIRES_TEXT, expDate ?? ""),
      ],
    );
  }
}

class CardHolderAndExpiresView extends StatelessWidget {
  final String title;
  final String info;

  CardHolderAndExpiresView(this.title, this.info);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: GHOST_BUTTON_BORDER_COLOR_ON_PRIMARY,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: MARGIN_SMALL,
        ),
        Text(
          info,
          style: const TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class VisaLogoAndMoreButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          "assets/images/visa_logo.png",
          width: VISA_LOGO_WIDTH,
          height: VISA_LOGO_HEIGHT,
        ),
        const Spacer(),
        const Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
      ],
    );
  }
}

class PaymentAmountSectionView extends StatelessWidget {
  final String? paymentAmount;

  PaymentAmountSectionView({required this.paymentAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          PAYMENT_AMOUNDT,
          style: TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          "\$ $paymentAmount",
          style: const TextStyle(
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
