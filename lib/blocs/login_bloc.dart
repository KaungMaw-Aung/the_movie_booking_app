import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';

class LoginBloc extends ChangeNotifier {
  /// States
  String? name, email, googleToken, facebookToken;

  /// Model
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  /// login
  Future<String?> login(String email, String password) {
    return movieBookingModel.loginWithEmail(email, password);
  }

  /// login with google
  Future<String?> loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      return movieBookingModel.loginWithGoogle(account.id);
    } else {
      return Future.error("account id null");
    }
  }

  /// login with facebook
  Future<String?> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      return movieBookingModel
          .loginWithFacebook(result.accessToken?.userId ?? "");
    } else {
      print(result.status);
      print(result.message);
      return Future.error("facebook login error");
    }
  }

  /// register
  Future<String?> register(
    String name,
    String number,
    String email,
    String password,
    String? googleToken,
    String? facebookToken,
  ) {
    return movieBookingModel.registerWithEmail(
      name,
      email,
      number,
      password,
      googleToken,
      facebookToken,
    );
  }

  /// register with google
  void registerWithGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        email = googleAccount.email;
        name = googleAccount.displayName;
        googleToken = googleAccount.id;
        notifyListeners();
      });
    });
  }

  /// register with facebook
  void registerWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      name = userData["name"].toString();
      email = userData["email"].toString();
      facebookToken = result.accessToken?.userId;
      notifyListeners();
    } else {
      print(result.status);
      print(result.message);
    }
  }
}
