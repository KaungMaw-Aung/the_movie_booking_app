import 'package:flutter/material.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';

class PrimaryButtonView extends StatelessWidget {
  final String buttonText;
  final bool isGhostButton;
  final bool isOnPrimaryBackground;
  final String iconUrl;
  final bool isElevated;
  final Function onTapButton;

  PrimaryButtonView(this.buttonText, this.onTapButton,
      {this.isGhostButton = false,
      this.isOnPrimaryBackground = true,
      this.isElevated = false,
      this.iconUrl = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapButton(),
      child: PhysicalModel(
        elevation: isElevated ? 16 : 0,
        color: Colors.transparent,
        child: Container(
          height: PRIMARY_BUTTON_HEIGHT,
          decoration: BoxDecoration(
            color: isGhostButton ? Colors.transparent : PRIMARY_COLOR,
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
            border: isGhostButton
                ? Border.all(
                    color: isOnPrimaryBackground
                        ? GHOST_BUTTON_BORDER_COLOR_ON_PRIMARY
                        : SECONDARY_WELCOME_TEXT_COLOR,
                    width: PRIMARY_BUTTON_BORDER_WIDTH,
                  )
                : null,
          ),
          margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Stack(
            children: [
              Visibility(
                visible: iconUrl.isNotEmpty,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: MARGIN_LARGE,
                    ),
                    child: Image.asset(
                      iconUrl,
                      width: PRIMARY_BUTTON_ICON_SIZE,
                      height: PRIMARY_BUTTON_ICON_SIZE,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: isOnPrimaryBackground
                        ? Colors.white
                        : SECONDARY_WELCOME_TEXT_COLOR,
                    fontSize: TEXT_REGULAR_2X,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
