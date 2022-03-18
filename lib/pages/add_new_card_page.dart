import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/add_new_card_bloc.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/utils/utils.dart';
import 'package:the_movie_booking_app/widgets/input_field_section_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';

class AddNewCardPage extends StatefulWidget {
  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController cvcController = TextEditingController();

  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddNewCardBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context, true),
            child: const Icon(Icons.chevron_left),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: InputFieldSectionView(
                CARD_NUMBER,
                controller: cardNumberController,
              ),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: InputFieldSectionView(
                CARD_HOLDER,
                controller: cardHolderController,
              ),
            ),
            const SizedBox(
              height: MARGIN_LARGE,
            ),
            Row(
              children: [
                const SizedBox(
                  width: MARGIN_MEDIUM_2,
                ),
                Expanded(
                  child: InputFieldSectionView(
                    CARD_EXPIRATION_DATE,
                    controller: expirationDateController,
                  ),
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM_2,
                ),
                Expanded(
                  child: InputFieldSectionView(
                    CARD_CVC,
                    controller: cvcController,
                  ),
                ),
                const SizedBox(
                  width: MARGIN_MEDIUM_2,
                ),
              ],
            ),
            const SizedBox(
              height: MARGIN_XXLARGE,
            ),
            Builder(
              builder: (context) => PrimaryButtonView(
                CONFIRM_BUTTON_TEXT,
                    () {
                  AddNewCardBloc bloc = Provider.of(context, listen: false);
                  bloc.createCard(
                    cardNumberController.text,
                    cardHolderController.text,
                    expirationDateController.text,
                    cvcController.text,
                  ).then((message) {
                    showToast(message ?? "create card succeed");
                    bloc.refreshUserCards().then((_) {
                      Navigator.pop(context);
                    }).catchError((error) => debugPrint(error));
                  }).catchError((error) => debugPrint(error));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardHolderController.dispose();
    expirationDateController.dispose();
    cvcController.dispose();

    super.dispose();
  }
}
