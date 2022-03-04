import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/pages/log_in_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';
import 'package:the_movie_booking_app/widgets/welcome_text_section_view.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: WelcomScreenImageView(),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Spacer(),
                  WelcomeTextSectionView(
                    "Hello! Welcome to Galaxy App.",
                    true,
                    true,
                  ),
                  const Spacer(),
                  PrimaryButtonView(
                    GET_STARTED_BUTTON_TEXT,
                    () => _navigateToAuthScreen(context),
                    isGhostButton: true,
                  ),
                  const SizedBox(
                    height: MARGIN_XLARGE,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _navigateToAuthScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LogInPage()));
  }
}

class WelcomScreenImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/welcome_movie_img.png",
      width: WELCOME_SCREEN_IMAGE_SIZE,
      height: WELCOME_SCREEN_IMAGE_SIZE,
    );
  }
}
