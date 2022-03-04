import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model.dart';
import 'package:the_movie_booking_app/data/models/movie_booking_model_impl.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/utils/utils.dart';
import 'package:the_movie_booking_app/widgets/input_field_section_view.dart';
import 'package:the_movie_booking_app/widgets/label_text_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';
import 'package:the_movie_booking_app/widgets/welcome_text_section_view.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final List<String> tabLabels = ["Login", "Sign in"];

  /// state variables
  String? name, phone, email, googleToken, facebookToken;

  MovieBookingModel movieBookingModel = MovieBookingModelImpl();

  @override
  void initState() {
    super.initState();
  }

  /// register
  _register(String name, String number, String email, String password,
      String? googleToken, String? facebookToken) {
    movieBookingModel
        .registerWithEmail(
            name, email, number, password, googleToken, facebookToken)
        .then((message) {
      showToast(message ?? "register succeed");
      _navigateToHomePage(context);
    }).catchError((error) {
      showToast(error.toString());
      debugPrint(error.toString());
    });
  }

  /// register with google
  _registerWithGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        setState(() {
          email = googleAccount.email;
          name = googleAccount.displayName;
          googleToken = googleAccount.id;
        });
      });
    });
  }

  /// register with facebook
  _registerWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      setState(() {
        name = userData["name"].toString();
        email = userData["email"].toString();
        facebookToken = result.accessToken?.userId;
      });
    } else {
      print(result.status);
      print(result.message);
    }
  }

  /// login
  _login(String email, String password) {
    movieBookingModel.loginWithEmail(email, password).then((message) {
      showToast(message ?? "login succeed");
      _navigateToHomePage(context);
    }).catchError((error) => debugPrint(error.toString()));
  }

  /// login with google
  _loginWithGoogle() {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    _googleSignIn.signIn().then((googleAccount) {
      googleAccount?.authentication.then((authentication) {
        print("id : ${googleAccount.id}");
        movieBookingModel
            .loginWithGoogle(googleAccount.id)
            .then((message) {
          showToast(message ?? "login with google succeed");
          _navigateToHomePage(context);
        }).catchError((error) {
          showToast(error.toString());
          debugPrint(error.toString());
        });
      });
    });
  }

  /// login with facebook
  _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
        movieBookingModel.loginWithFacebook(result.accessToken?.userId ?? "")
            .then((message) {
          showToast(message ?? "login with facebook succeed");
          _navigateToHomePage(context);
        }).catchError((error) {
          showToast(error.toString());
          debugPrint(error.toString());
        });
    } else {
      print(result.status);
      print(result.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: SIGN_IN_SCREEN_TOP_MARGIN,
            ),
            Padding(
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              child: WelcomeTextSectionView(
                "Welcome back, login to continue",
                false,
                false,
              ),
            ),
            const SizedBox(
              height: MARGIN_XLARGE,
            ),
            AuthSectionView(
              email: email,
              phone: phone,
              name: name,
              facebookToken: facebookToken,
              googleToken: googleToken,
              onTapLoginConfirmButton: (String email, String password) => _login(email, password),
              tabLabels: tabLabels,
              onTapRegisterConfirmButton: (
                  String name,
                  String number,
                  String email,
                  String password,
                  String? googleToken,
                  String? facebookToken,
                  ) =>
                  _register(
                    name,
                    number,
                    email,
                    password,
                    googleToken,
                    facebookToken,
                  ),
              onTapSignInWithGoogle: () => _registerWithGoogle(),
              onTapSignInWithFacebook: () => _registerWithFacebook(),
              onTapLoginWithGoogle: () => _loginWithGoogle(),
              onTapLoginWithFacebook: () => _loginWithFacebook(),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToHomePage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

}

class AuthSectionView extends StatefulWidget {
  AuthSectionView({
    required this.tabLabels,
    required this.onTapSignInWithFacebook,
    required this.onTapSignInWithGoogle,
    required this.onTapLoginConfirmButton,
    required this.onTapRegisterConfirmButton,
    required this.name,
    required this.email,
    required this.phone,
    required this.googleToken,
    required this.facebookToken,
    required this.onTapLoginWithGoogle,
    required this.onTapLoginWithFacebook,
  });

  final List<String> tabLabels;
  final Function onTapSignInWithFacebook;
  final Function onTapSignInWithGoogle;
  final Function(String email, String password) onTapLoginConfirmButton;
  final Function(String name, String number, String email, String password,
      String?, String?) onTapRegisterConfirmButton;
  final String? name, email, phone, googleToken, facebookToken;
  final Function onTapLoginWithGoogle;
  final Function onTapLoginWithFacebook;

  @override
  State<AuthSectionView> createState() => _AuthSectionViewState();
}

class _AuthSectionViewState extends State<AuthSectionView> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: DefaultTabController(
            length: widget.tabLabels.length,
            child: TabBar(
              isScrollable: false,
              indicatorColor: PRIMARY_COLOR,
              labelColor: PRIMARY_COLOR,
              labelPadding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM),
              indicatorWeight: 4.0,
              unselectedLabelColor: PRIMARY_WELCOME_TEXT_COLOR,
              onTap: (index) => setState(() => _activeTab = index),
              tabs:
                  widget.tabLabels.map((label) => TabTextView(label)).toList(),
            ),
          ),
        ),
        const SizedBox(
          height: MARGIN_XXLARGE,
        ),
        Stack(
          children: [
            Visibility(
              visible: _activeTab == 0,
              child: LoginSectionView(
                widget.onTapLoginWithFacebook,
                widget.onTapLoginWithGoogle,
                widget.onTapLoginConfirmButton,
              ),
            ),
            Visibility(
              visible: _activeTab == 1,
              child: SignInSectionView(
                widget.onTapSignInWithFacebook,
                widget.onTapSignInWithGoogle,
                widget.onTapRegisterConfirmButton,
                email: widget.email,
                phone: widget.phone,
                name: widget.name,
                googleToken: widget.googleToken,
                facebookToken: widget.facebookToken,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SignInSectionView extends StatefulWidget {
  final Function onTapSignInWithFacebook;
  final Function onTapSignInWithGoogle;
  final Function(String, String, String, String, String?, String?)
      onTapConfirmButton;
  final String? name, email, phone, googleToken, facebookToken;

  SignInSectionView(
    this.onTapSignInWithFacebook,
    this.onTapSignInWithGoogle,
    this.onTapConfirmButton, {
    required this.name,
    required this.email,
    required this.phone,
    required this.googleToken,
    required this.facebookToken,
  });

  @override
  State<SignInSectionView> createState() => _SignInSectionViewState();
}

class _SignInSectionViewState extends State<SignInSectionView> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InputFieldSectionView(
            NAME_LABEL_TEXT,
            controller: nameController,
            initialText: widget.name ?? "",
          ),
        ),
        const SizedBox(
          height: MARGIN_XXLARGE,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InputFieldSectionView(
            PHONE_NUMBER_LABEL_TEXT,
            inputType: TextInputType.number,
            controller: numberController,
            initialText: widget.phone ?? "",
          ),
        ),
        const SizedBox(
          height: MARGIN_XXLARGE,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InputFieldSectionView(
            EMAIL_LABEL_TEXT,
            controller: emailController,
            initialText: widget.email ?? "",
          ),
        ),
        const SizedBox(
          height: MARGIN_XXLARGE,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InputFieldSectionView(
            PASSWORD_LABEL_TEXT,
            isPasswordField: true,
            controller: passwordController,
          ),
        ),
        const SizedBox(
          height: MARGIN_XLARGE,
        ),
        SignInOptionsAndConfirmButtonSectionView(
          widget.onTapSignInWithFacebook,
          widget.onTapSignInWithGoogle,
          () => widget.onTapConfirmButton(
            nameController.text,
            numberController.text,
            emailController.text,
            passwordController.text,
            widget.googleToken,
            widget.facebookToken,
          ),
        ),
        const SizedBox(
          height: MARGIN_XLARGE,
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}

class LoginSectionView extends StatefulWidget {
  final Function onTapSignInWithFacebook;
  final Function onTapSignInWithGoogle;
  final Function(String, String) onTapConfirmButton;

  LoginSectionView(this.onTapSignInWithFacebook, this.onTapSignInWithGoogle,
      this.onTapConfirmButton);

  @override
  State<LoginSectionView> createState() => _LoginSectionViewState();
}

class _LoginSectionViewState extends State<LoginSectionView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InputFieldSectionView(
            EMAIL_LABEL_TEXT,
            controller: emailController,
          ),
        ),
        const SizedBox(
          height: MARGIN_XXLARGE,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InputFieldSectionView(
            PASSWORD_LABEL_TEXT,
            isPasswordField: true,
            controller: passwordController,
          ),
        ),
        const SizedBox(
          height: MARGIN_XLARGE,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: LabelTextView(FORGOT_PASSWORD_TEXT),
        ),
        const SizedBox(
          height: MARGIN_XLARGE,
        ),
        SignInOptionsAndConfirmButtonSectionView(
          widget.onTapSignInWithFacebook,
          widget.onTapSignInWithGoogle,
          () => widget.onTapConfirmButton(
              emailController.text, passwordController.text),
        ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}

class SignInOptionsAndConfirmButtonSectionView extends StatelessWidget {
  final Function onTapSignInWithFacebook;
  final Function onTapSignInWithGoogle;
  final Function onTapConfirmButton;

  SignInOptionsAndConfirmButtonSectionView(this.onTapSignInWithFacebook,
      this.onTapSignInWithGoogle, this.onTapConfirmButton);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButtonView(
          SIGN_IN_WITH_FACEBOOK_TEXT,
          onTapSignInWithFacebook,
          isGhostButton: true,
          isOnPrimaryBackground: false,
          iconUrl: "assets/images/facebook_logo.png",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        PrimaryButtonView(
          SIGN_IN_WITH_GOOGLE_TEXT,
          onTapSignInWithGoogle,
          isGhostButton: true,
          isOnPrimaryBackground: false,
          iconUrl: "assets/images/google_logo.png",
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        PrimaryButtonView(
          CONFIRM_BUTTON_TEXT,
          onTapConfirmButton,
          isElevated: true,
        ),
      ],
    );
  }
}

class TabTextView extends StatelessWidget {
  final String tabLabel;

  TabTextView(this.tabLabel);

  @override
  Widget build(BuildContext context) {
    return Text(
      tabLabel,
      style: const TextStyle(
        fontSize: TEXT_REGULAR_2X,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
