import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_req_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';
import 'package:the_movie_booking_app/network/responses/checkout_request.dart';
import 'package:the_movie_booking_app/pages/add_new_card_page.dart';
import 'package:the_movie_booking_app/pages/ticket_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

class ChooseCardPage extends StatefulWidget {
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
  State<ChooseCardPage> createState() {
    return _ChooseCardPageState();
  }
}

class _ChooseCardPageState extends State<ChooseCardPage> {
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  /// state variables
  List<CardVO>? cards;

  int? cardIndex;

  @override
  void initState() {

    movieBookingModel.getUserCardsFromDatabase().listen((cards) {
      setState(() {
        this.cards = cards;
      });
    }).onError((error) => debugPrint(error.toString()));

    super.initState();
  }

  // void _getUserCards() {
  //   movieBookingModel.getUserCards().then((cards) {
  //     setState(() {
  //       this.cards = cards;
  //     });
  //   }).catchError((error) => debugPrint(error.toString()));
  // }

  void _checkout(
    int cinemaDayTimeslotId,
    String row,
    String seatNumber,
    String bookingDate,
    double totalPrice,
    int movieId,
    int cardId,
    int cinemaId,
    List<SnackReqVO> snacks,
  ) {
    movieBookingModel
        .checkout(CheckoutRequest(
      cinemaDayTimeslotId,
      row,
      seatNumber,
      bookingDate,
      totalPrice,
      movieId,
      cardId,
      cinemaId,
      snacks,
    ))
        .then((voucher) {
      _navigateToTicketPage(context, voucher);
    }).catchError((error) {
      debugPrint(error.toString());
    });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: PaymentAmountSectionView(
              paymentAmount: widget.totalAmount,
            ),
          ),
          const SizedBox(
            height: MARGIN_XLARGE,
          ),
          Container(
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
                        onPageChanged: (index, _) => cardIndex = index),
                    items:
                        cards?.map((each) => CardView(card: each)).toList() ??
                            [],
                  )
                : const Center(
                    child: Text("You currently have no cards added."),
                  ),
          ),
          const SizedBox(
            height: MARGIN_XLARGE,
          ),
          Padding(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            child: GestureDetector(
              onTap: () => _navigateToAddNewCardPageAndWaitResult(context),
              child: AddNewCardButtonView(),
            ),
          ),
          const Spacer(),
          PrimaryButtonView(
            PURCHASE,
            () => _checkout(
                widget.cinemaDayTimeslotId,
                widget.row,
                widget.seatNumbers,
                widget.bookingDate,
                double.parse(widget.totalAmount),
                widget.movieId,
                cards?[cardIndex ?? 0].id ?? -1,
                widget.cinemaId,
                widget.snacks),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM_2,
          ),
        ],
      ),
    );
  }

  void _navigateToAddNewCardPageAndWaitResult(BuildContext context) {
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
          moviePosterUrl: widget.moviePosterUrl,
          cinema: widget.cinema,
          movieTitle: widget.movieTitle,
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
