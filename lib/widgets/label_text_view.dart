import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class LabelTextView extends StatelessWidget {

  LabelTextView(
    this.secondaryText, {
    this.isOnPrimaryBackground = false,
  });

  final String secondaryText;
  final bool isOnPrimaryBackground;

  @override
  Widget build(BuildContext context) {
    return Text(
      secondaryText,
      style: TextStyle(
        color: isOnPrimaryBackground
            ? GHOST_BUTTON_BORDER_COLOR_ON_PRIMARY
            : SECONDARY_WELCOME_TEXT_COLOR,
        fontSize: TEXT_REGULAR,
      ),
    );
  }
}
