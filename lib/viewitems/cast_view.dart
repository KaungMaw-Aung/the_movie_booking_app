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
      height: MOVIE_DETAILS_CAST_SIZE,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            (castImgUrl != null) ?
            "$IMAGE_BASE_URL${castImgUrl ?? ""}" :
            "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/104113705/original/6076831db34315e45bd2a31a9d79bb7b91d48e04/design-flat-style-minimalist-avatar-of-you.jpg",
          ),
        ),
      ),
    );
  }
}