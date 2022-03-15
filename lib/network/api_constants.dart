/// Base Url
const String BASE_URL_DIO = "https://tmba.padc.com.mm";
const String TMDB_BASE_URL_DIO = "https://api.themoviedb.org";
const String IMAGE_BASE_URL = "http://image.tmdb.org/t/p/w400";

/// Endpoints
const String ENDPOINT_REGISTER_WITH_EMAIL = "/api/v1/register";
const String ENDPOINT_LOGOUT = "/api/v1/logout";
const String ENDPOINT_LOGIN_WITH_EMAIL = "/api/v1/email-login";
const String ENDPOINT_NOW_PLAYING_MOVIES = "/3/movie/now_playing";
const String ENDPOINT_COMING_SOON_MOVIES = "/3/movie/upcoming";
const String ENDPOINT_MOVIE_DETAIL = "/3/movie";
const String ENDPOINT_GET_CINEMA_DAY_TIMESLOT = "/api/v1/cinema-day-timeslots";
const String ENDPOINT_CINEMA_SEATING_PLAN = "/api/v1/seat-plan";
const String ENDPOINT_GET_SNACK_LIST = "/api/v1/snacks";
const String ENDPOINT_GET_PAYMENT_METHOD_LIST = "/api/v1/payment-methods";
const String ENDPOINT_PROFILE = "/api/v1/profile";
const String ENDPOINT_CREATE_CARD = "/api/v1/card";
const String ENDPOINT_CHECKOUT = "/api/v1/checkout";
const String ENDPOINT_LOGIN_WITH_GOOGLE = "/api/v1/google-login";
const String ENDPOINT_LOGIN_WITH_FACEBOOK = "/api/v1/facebook-login";

/// Parameters
const String PARAM_API_KEY = "api_key";
const String PARAM_LANGUAGE = "language";
const String PARAM_PAGE = "page";
const String PARAM_DATE = "date";
const String PARAM_MOVIE_ID = "movie_id";
const String PARAM_CINEMA_DAY_TIMESLOT_ID = "cinema_day_timeslot_id";
const String PARAM_BOOKING_DATE = "booking_date";

/// Header Keys
const String KEY_AUTHORIZATION = "Authorization";

/// Form Data Keys
const String KEY_NAME = "name";
const String KEY_EMAIL = "email";
const String KEY_PHONE = "phone";
const String KEY_PASSWORD = "password";
const String KEY_GOOGLE_ACCESS_TOKEN = "google-access-token";
const String KEY_FACEBOOK_ACCESS_TOKEN = "facebook-access-token";
const String KEY_CARD_NUMBER = "card_number";
const String KEY_CARD_HOLDER = "card_holder";
const String KEY_EXPIRATION_DATE = "expiration_date";
const String KEY_CVC = "cvc";
const String KEY_ACCESS_TOKEN = "access-token";

/// Constant Values
const String API_KEY = "948d1ec7e82027d36cf4ceb80ee7632c";
const String LANGUAGE_EN_US = "en-US";

const int RESPONSE_CODE_SUCCESS = 200;
