import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class SubHeadingTextView extends StatelessWidget {
  final String subTitle;

  SubHeadingTextView(this.subTitle);

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: const TextStyle(
        fontSize: TEXT_CARD_REGULAR_2X,
        fontWeight: FontWeight.w600,
        color: PRIMARY_WELCOME_TEXT_COLOR,
      ),
    );
  }
}