import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';

import 'label_text_view.dart';

class WelcomeTextSectionView extends StatelessWidget {
  final String secondaryText;
  final bool isAlignCentered;
  final bool isOnPrimaryBackground;

  WelcomeTextSectionView(
      this.secondaryText, this.isAlignCentered, this.isOnPrimaryBackground);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isAlignCentered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          WELCOME_TEXT,
          style: TextStyle(
            color: isOnPrimaryBackground
                ? Colors.white
                : PRIMARY_WELCOME_TEXT_COLOR,
            fontSize: TEXT_HEADING_1X,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM,
        ),
        LabelTextView(secondaryText, isOnPrimaryBackground: isOnPrimaryBackground),
      ],
    );
  }
}

