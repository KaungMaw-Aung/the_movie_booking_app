import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_booking_app/blocs/login_bloc.dart';
import 'package:the_movie_booking_app/pages/home_page.dart';
import 'package:the_movie_booking_app/resources/colors.dart';
import 'package:the_movie_booking_app/resources/dimens.dart';
import 'package:the_movie_booking_app/resources/strings.dart';
import 'package:the_movie_booking_app/utils/utils.dart';
import 'package:the_movie_booking_app/widgets/input_field_section_view.dart';
import 'package:the_movie_booking_app/widgets/label_text_view.dart';
import 'package:the_movie_booking_app/widgets/primary_button_view.dart';
import 'package:the_movie_booking_app/widgets/welcome_text_section_view.dart';

class LogInPage extends StatelessWidget {
  final List<String> tabLabels = ["Login", "Sign in"];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
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
              Builder(
                builder: (context) {
                  LoginBloc bloc = Provider.of(context, listen: false);
                  return AuthSectionView(
                    onTapLoginConfirmButton: (String email, String password) {
                      bloc.login(email, password).then((message) {
                        showToast(message ?? "login succeed");
                        _navigateToHomePage(context);
                      }).catchError(
                          (error) => showToast(error ?? "login succeed"));
                    },
                    tabLabels: tabLabels,
                    onTapRegisterConfirmButton: (
                      String name,
                      String number,
                      String email,
                      String password,
                      String? googleToken,
                      String? facebookToken,
                    ) {
                      // print("register data: $name, $number, $email, $googleToken, $facebookToken");
                      bloc.register(
                        name,
                        number,
                        email,
                        password,
                        googleToken,
                        facebookToken,
                      ).then((message) {
                        showToast(message ?? "register succeed");
                        _navigateToHomePage(context);
                      }).catchError((error) {
                        showToast(error.toString());
                        debugPrint(error.toString());
                      });
                    },
                    onTapSignInWithGoogle: () => bloc.registerWithGoogle(),
                    onTapSignInWithFacebook: () => bloc.registerWithFacebook(),
                    onTapLoginWithGoogle: () {
                      bloc.loginWithGoogle().then((message) {
                        showToast(message ?? "login with google succeed");
                        _navigateToHomePage(context);
                      }).catchError((error) {
                        showToast(error.toString());
                        debugPrint(error.toString());
                      });
                    },
                    onTapLoginWithFacebook: () =>
                        bloc.loginWithFacebook().then((message) {
                      showToast(message ?? "login with facebook succeed");
                      _navigateToHomePage(context);
                    }).catchError((error) {
                      showToast(error.toString());
                      debugPrint(error.toString());
                    }),
                  );
                },
              ),
            ],
          ),
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
    required this.onTapLoginWithGoogle,
    required this.onTapLoginWithFacebook,
  });

  final List<String> tabLabels;
  final Function onTapSignInWithFacebook;
  final Function onTapSignInWithGoogle;
  final Function(String email, String password) onTapLoginConfirmButton;
  final Function(String name, String number, String email, String password,
      String?, String?) onTapRegisterConfirmButton;
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

  SignInSectionView(
    this.onTapSignInWithFacebook,
    this.onTapSignInWithGoogle,
    this.onTapConfirmButton,
  );

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
          child: Selector<LoginBloc, String?>(
            selector: (context, bloc) => bloc.name,
            builder: (context, name, child) => InputFieldSectionView(
              NAME_LABEL_TEXT,
              controller: nameController,
              initialText: name ?? "",
            ),
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
          ),
        ),
        const SizedBox(
          height: MARGIN_XXLARGE,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Selector<LoginBloc, String?>(
            selector: (context, bloc) => bloc.email,
            builder: (context, email, child) => InputFieldSectionView(
              EMAIL_LABEL_TEXT,
              controller: emailController,
              initialText: email ?? "",
            ),
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
          () {
            LoginBloc bloc = Provider.of(context, listen: false);
            widget.onTapConfirmButton(
              nameController.text,
              numberController.text,
              emailController.text,
              passwordController.text,
              bloc.googleToken,
              bloc.facebookToken,
            );
          },
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
