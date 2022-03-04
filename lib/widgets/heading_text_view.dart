import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class HeadingTextView extends StatelessWidget {
  final String? title;

  HeadingTextView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      style: const TextStyle(
        fontSize: TEXT_HEADING_1X,
        fontWeight: FontWeight.w500,
        color: PRIMARY_WELCOME_TEXT_COLOR,
      ),
    );
  }
}