import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class DottedLineSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.0,
      dashLength: MARGIN_MEDIUM,
      dashColor: MOVIE_SEAT_DASH_LINE_COLOR,
      dashGapLength: MARGIN_MEDIUM,
      dashGapColor: Colors.transparent,
      dashGapRadius: 0.0,
    );
  }
}