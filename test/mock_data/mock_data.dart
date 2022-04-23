import 'package:the_movie_booking_app/data/vos/card_vo.dart';
import 'package:the_movie_booking_app/data/vos/cast_vo.dart';
import 'package:the_movie_booking_app/data/vos/cinema_vo.dart';
import 'package:the_movie_booking_app/data/vos/genre_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:the_movie_booking_app/data/vos/movie_vo.dart';
import 'package:the_movie_booking_app/data/vos/payment_vo.dart';
import 'package:the_movie_booking_app/data/vos/snack_vo.dart';
import 'package:the_movie_booking_app/data/vos/timeslot_vo.dart';
import 'package:the_movie_booking_app/data/vos/user_vo.dart';
import 'package:the_movie_booking_app/data/vos/voucher_vo.dart';

List<CardVO> getMockCards() {
  return [
    CardVO(0, "Maw", "000 000 000", "12/8", "Credit Card"),
    CardVO(1, "Kaung", "111 111 111", "8/12", "Credit Card"),
  ];
}

UserVO getMockUser() {
  return UserVO(0, "Mock User", "mockuser@gmail.com", "09123456", 5,
      "mockprofile.jpg", getMockCards(), "111222333");
}

String getLogOutSucceedMessage() => "Log out successfully";

List<MovieVO> getMockMovies() {
  return [
    MovieVO(
      false,
      "/fOy2Jurz9k6RnJnMUMRDAgBwru2.jpg",
      [16, 10751, 35, 14],
      508947,
      "en",
      "Turning Red",
      "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
      6261.493,
      "/qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ.jpg",
      "2022-03-01",
      "Turning Red",
      false,
      7.5,
      1403,
      null,
      null,
      isNowPlaying: true,
      isComingSoon: false,
    ),
    MovieVO(
      false,
      "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
      [28, 12, 878],
      634649,
      "en",
      "Spider-Man: No Way Home",
      "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
      6646,
      "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
      "2021-12-15",
      "Spider-Man: No Way Home",
      false,
      8.2,
      10971,
      null,
      null,
      isNowPlaying: false,
      isComingSoon: true,
    ),
  ];
}

MovieVO getMockMovie() {
  return MovieVO(
    false,
    "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
    [28, 12, 878],
    634649,
    "en",
    "Spider-Man: No Way Home",
    "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
    6646,
    "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg",
    "2021-12-15",
    "Spider-Man: No Way Home",
    false,
    8.2,
    10971,
    [
      GenreVO(28, "Action"),
      GenreVO(12, "Adventure"),
      GenreVO(878, "Science Fiction"),
    ],
    148,
    isNowPlaying: true,
    isComingSoon: false,
  );
}

List<CastVO> getMockCasts() {
  return [
    CastVO(0, "Mock Cast One", "mock_cast_one.jpg", [508947]),
    CastVO(1, "Mock Cast Two", "mock_cast_two.jpg", [634649]),
  ];
}

List<CinemaVO> getMockCinemas() {
  return [
    CinemaVO(1, "Cinema I",
        [TimeslotVO(9, "9:30 AM"), TimeslotVO(10, "12:00 PM")], ["2022-04-22"]),
    CinemaVO(2, "Cinema II", [
      TimeslotVO(23, "10:00 AM"),
      TimeslotVO(24, "1:30 PM"),
    ], [
      "2022-04-22"
    ]),
    CinemaVO(3, "Cinema III", [
      TimeslotVO(41, "9:30 AM"),
      TimeslotVO(42, "12:00 PM"),
      TimeslotVO(43, "4:30 PM")
    ], [
      "2022-04-22"
    ]),
  ];
}

List<List<MovieSeatVO>> getMockMovieSeats() {
  return [
    [
      MovieSeatVO(1, "text", "", "A", 0),
      MovieSeatVO(2, "space", "", "A", 0),
      MovieSeatVO(3, "available", "A-2", "A", 2),
    ],
    [
      MovieSeatVO(1, "text", "", "B", 0),
      MovieSeatVO(2, "available", "B-1", "B", 2),
      MovieSeatVO(3, "available", "B-2", "B", 2),
    ],
  ];
}

List<SnackVO> getMockSnacks() {
  return [
    SnackVO(1, "Popcorn", "Et dolores eaque officia aut.", 2.0),
    SnackVO(2, "Smoothies",
        "Voluptatum consequatur aut molestiae soluta nulla.", 3.0),
    SnackVO(3, "Carrots", "At vero et doloribus sint porro ipsum consequatur.",
        4.0),
  ];
}

List<PaymentVO> getMockPayments() {
  return [
    PaymentVO(1, "Credit card", "Visa, Master Card, JCB"),
    PaymentVO(2, "Internet Banking (ATM card)", "Visa, Master Card, JCB"),
    PaymentVO(3, "E-Wallet", "AyaPay, KbzPay, WavePay"),
  ];
}

String createNewCardSucceedMessage() => "New Card Created";

VoucherVO getMockVoucher() {
  return VoucherVO(
    0,
    "1",
    "2022-4-22",
    "B",
    "B-3",
    1,
    "5.0",
    1,
    2,
    "Maw Gyi",
    TimeslotVO(9, "9:30 AM"),
    getMockSnacks(),
    "voucher_qr_code",
  );
}
