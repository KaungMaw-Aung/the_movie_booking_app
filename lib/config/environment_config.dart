class EnvironmentConfig {
  static const String CONFIG_THEME_COLOR = String.fromEnvironment(
      "CONFIG_THEME_COLOR",
      defaultValue: "COLOR_GALAXY_APP");

  static const String CONFIG_WELCOME_GRAPHIC = String.fromEnvironment(
      "CONFIG_WELCOME_GRAPHIC",
      defaultValue: "GRAPHIC_GALAXY_APP");

  static const String CONFIG_HOME_MOVIES_LAYOUT = String.fromEnvironment(
      "CONFIG_HOME_MOVIES_LAYOUT",
      defaultValue: "MOVIES_LAYOUT_GALAXY_APP");

  static const String CONFIG_CASTS_LAYOUT = String.fromEnvironment(
      "CONFIG_CASTS_LAYOUT",
      defaultValue: "CASTS_LAYOUT_GALAXY_APP");

  static const String CONFIG_APP_TITLE = String.fromEnvironment(
      "CONFIG_APP_TITLE",
      defaultValue: "APP_TITLE_GALAXY_APP");
}

/// FLAVORS

/// Galaxy App
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_GALAXY_APP --dart-define=CONFIG_WELCOME_GRAPHIC=GRAPHIC_GALAXY_APP --dart-define=CONFIG_HOME_MOVIES_LAYOUT=MOVIES_LAYOUT_GALAXY_APP --dart-define=CONFIG_CASTS_LAYOUT=CASTS_LAYOUT_GALAXY_APP --dart-define=CONFIG_APP_TITLE=APP_TITLE_GALAXY_APP

/// Movie App
/// flutter run --dart-define=CONFIG_THEME_COLOR=COLOR_MOVIE_APP --dart-define=CONFIG_WELCOME_GRAPHIC=GRAPHIC_MOVIE_APP --dart-define=CONFIG_HOME_MOVIES_LAYOUT=MOVIES_LAYOUT_MOVIE_APP --dart-define=CONFIG_CASTS_LAYOUT=CASTS_LAYOUT_MOVIE_APP --dart-define=CONFIG_APP_TITLE=APP_TITLE_MOVIE_APP