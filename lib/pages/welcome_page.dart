import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/config/environment_config.dart';
import 'package:the_movie_booking_app/pages/log_in_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';
import 'package:the_movie_booking_app/widgets/welcome_text_section_view.dart';

import '../config/config_values.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
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
                    "Hello! Welcome to ${APP_TITLES[EnvironmentConfig.CONFIG_APP_TITLE]}.",
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
      WELCOME_GRAPHICS[EnvironmentConfig.CONFIG_WELCOME_GRAPHIC] ?? "",
      width: WELCOME_SCREEN_IMAGE_SIZE,
      height: WELCOME_SCREEN_IMAGE_SIZE,
    );
  }
}
