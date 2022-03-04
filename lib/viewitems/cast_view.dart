import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/network/api_constants.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class CastView extends StatelessWidget {

  final String? castImgUrl;

  CastView({required this.castImgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_LARGE),
      width: MOVIE_DETAILS_CAST_SIZE,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "$IMAGE_BASE_URL${castImgUrl ?? ""}",
          ),
        ),
      ),
    );
  }
}