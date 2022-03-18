import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/snack_bloc.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_req_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/pages/choose_card_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

class MovieSnackPage extends StatelessWidget {
  final double ticketsPrice;
  final String row;
  final int movieId;
  final int cinemaId;
  final int cinemaDayTimeslotId;
  final String bookingDate;
  final String seatNumbers;
  final String moviePosterUrl;
  final String movieTitle;
  final String cinema;

  MovieSnackPage({
    required this.ticketsPrice,
    required this.row,
    required this.movieId,
    required this.cinemaId,
    required this.cinemaDayTimeslotId,
    required this.bookingDate,
    required this.seatNumbers,
    required this.moviePosterUrl,
    required this.movieTitle,
    required this.cinema,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SnackBloc(ticketsPrice),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.chevron_left),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Selector<SnackBloc, bool>(
                selector: (context, bloc) => bloc.snacksQtyTrigger,
                builder: (context, _, child) {
                  return Selector<SnackBloc, List<SnackVO>?>(
                    selector: (context, bloc) => bloc.snacks,
                    builder: (context, snacks, child) {
                      SnackBloc bloc = Provider.of(context, listen: false);
                      return ComboSetSectionView(
                        snacks: snacks,
                        onDecrease: (snack) {
                          bloc.onTapSnackQtyDecrease(snack);
                        },
                        onIncrease: (snack) {
                          bloc.onTapSnackQtyIncrease(snack);
                        },
                      );
                    },
                  );
                },
              ),
              Selector<SnackBloc, double>(
                selector: (context, bloc) => bloc.subTotal,
                builder: (context, subTotal, child) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: PromoCodeAndSubTotalSectionView(
                      subTotal: subTotal,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: MARGIN_LARGE,
              ),
              Selector<SnackBloc, bool>(
                selector: (context, bloc) => bloc.selectPaymentTrigger,
                builder: (context, _, child) {
                  return Selector<SnackBloc, List<PaymentVO>?>(
                    selector: (context, bloc) => bloc.paymentMethods,
                    builder: (context, paymentMethods, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: MARGIN_MEDIUM_2),
                        child: PaymentMethodSectionView(
                          paymentMethods: paymentMethods,
                          onTapPayment: (paymentId) {
                            SnackBloc bloc =
                                Provider.of(context, listen: false);
                            bloc.onTapPayment(paymentId);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              Selector<SnackBloc, double>(
                selector: (context, bloc) => bloc.subTotal,
                builder: (context, subTotal, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: MARGIN_LARGE),
                    child: PrimaryButtonView(
                      "Pay \$ $subTotal",
                      () => _navigateToChooseCardPage(context),
                      isElevated: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToChooseCardPage(BuildContext context) {
    SnackBloc bloc = Provider.of(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChooseCardPage(
          totalAmount: bloc.subTotal.toString(),
          snacks: bloc.snacks
                  ?.map((snack) => SnackReqVO(snack.id, snack.quantity))
                  .toList() ??
              [],
          row: row,
          movieId: movieId,
          cinemaId: cinemaId,
          cinemaDayTimeslotId: cinemaDayTimeslotId,
          bookingDate: bookingDate,
          seatNumbers: seatNumbers,
          movieTitle: movieTitle,
          moviePosterUrl: moviePosterUrl,
          cinema: cinema,
        ),
      ),
    );
  }
}

class PaymentMethodSectionView extends StatelessWidget {
  final List<PaymentVO>? paymentMethods;
  final Function(int) onTapPayment;

  PaymentMethodSectionView({
    required this.paymentMethods,
    required this.onTapPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          PAYMENT_METHOD,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: TEXT_REGULAR_3X,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        ListView(
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: paymentMethods
                  ?.map(
                    (each) => PaymentMethodItemView(
                      paymentMethod: each,
                      onTapPayment: onTapPayment,
                    ),
                  )
                  .toList() ??
              [],
        ),
      ],
    );
  }
}

class PaymentMethodItemView extends StatelessWidget {
  final PaymentVO? paymentMethod;
  final Function(int) onTapPayment;

  PaymentMethodItemView({
    required this.paymentMethod,
    required this.onTapPayment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapPayment(paymentMethod?.id ?? -1),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM,
          vertical: MARGIN_SMALL,
        ),
        decoration: BoxDecoration(
          color: (paymentMethod?.isSelected == true)
              ? PRIMARY_COLOR
              : Colors.white,
          border: Border.all(
              color: (paymentMethod?.isSelected == true)
                  ? PRIMARY_COLOR
                  : Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(MARGIN_MEDIUM)),
        ),
        margin: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
        child: Row(
          children: [
            Icon(
              Icons.payment,
              color: (paymentMethod?.isSelected == true)
                  ? Colors.white
                  : PAYMENT_METHODS_ICON_COLOR,
            ),
            const SizedBox(
              width: MARGIN_LARGE,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentMethod?.name ?? "",
                  style: TextStyle(
                    fontSize: TEXT_REGULAR_2X,
                    color: (paymentMethod?.isSelected == true)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                Text(
                  paymentMethod?.description ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: (paymentMethod?.isSelected == true)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PromoCodeAndSubTotalSectionView extends StatelessWidget {
  final double subTotal;

  PromoCodeAndSubTotalSectionView({required this.subTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          decoration: InputDecoration(
              hintText: ENTER_PROMO_CODE_HINT_TEXT,
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
                fontSize: TEXT_REGULAR_2X,
              )),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Row(
          children: const [
            Text(
              DONT_HAVE_ANY_PROMO_CODE_TEXT,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(
              width: MARGIN_SMALL,
            ),
            Text(
              GET_IT_NOW_TEXT,
            ),
          ],
        ),
        const SizedBox(
          height: MARGIN_LARGE,
        ),
        Text(
          "Sub total: $subTotal \$",
          style: const TextStyle(
            color: Color.fromRGBO(4, 207, 140, 1.0),
            fontSize: TEXT_REGULAR_2X,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ComboSetSectionView extends StatelessWidget {
  final List<SnackVO>? snacks;
  final Function(SnackVO?) onIncrease;
  final Function(SnackVO?) onDecrease;

  ComboSetSectionView({
    required this.snacks,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: snacks
              ?.map((snack) => ComboSetViewItem(
                    snack: snack,
                    onIncrease: onIncrease,
                    onDecrease: onDecrease,
                  ))
              .toList() ??
          [],
    );
  }
}

class ComboSetViewItem extends StatelessWidget {
  final SnackVO? snack;
  final Function(SnackVO?) onIncrease;
  final Function(SnackVO?) onDecrease;

  ComboSetViewItem({
    required this.snack,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2),
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1.8 / 3,
            child: ComboSetNameAndInfoView(
              name: snack?.name,
              description: snack?.description,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                "${snack?.price ?? 0.0}\$",
                style: const TextStyle(
                  fontSize: TEXT_REGULAR_3X,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: MARGIN_MEDIUM,
              ),
              ComboSetQtyButtonGroupView(
                onDecrease: () => onDecrease(snack),
                onIncrease: () => onIncrease(snack),
                quantity: snack?.quantity ?? 0,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ComboSetQtyButtonGroupView extends StatelessWidget {
  final Function onIncrease;
  final Function onDecrease;
  final int quantity;

  ComboSetQtyButtonGroupView({
    required this.onIncrease,
    required this.onDecrease,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: COMBO_SET_BUTTON_GROUP_SIZE,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onDecrease(),
            child: Container(
              width: COMBO_SET_BUTTON_GROUP_SIZE,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(MARGIN_MEDIUM),
                  bottomLeft: Radius.circular(MARGIN_MEDIUM),
                ),
                border: Border.all(
                  color: SECONDARY_WELCOME_TEXT_COLOR,
                ),
              ),
              child: const Center(
                child: Text("-"),
              ),
            ),
          ),
          Container(
            width: COMBO_SET_BUTTON_GROUP_SIZE,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: SECONDARY_WELCOME_TEXT_COLOR),
                bottom: BorderSide(color: SECONDARY_WELCOME_TEXT_COLOR),
              ),
            ),
            child: Center(
              child: Text("$quantity"),
            ),
          ),
          GestureDetector(
            onTap: () => onIncrease(),
            child: Container(
              width: COMBO_SET_BUTTON_GROUP_SIZE,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(MARGIN_MEDIUM),
                  bottomRight: Radius.circular(MARGIN_MEDIUM),
                ),
                border: Border.all(
                  color: SECONDARY_WELCOME_TEXT_COLOR,
                ),
              ),
              child: const Center(
                child: Text("+"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComboSetNameAndInfoView extends StatelessWidget {
  final String? name;
  final String? description;

  ComboSetNameAndInfoView({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "",
          style: const TextStyle(
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          description ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
