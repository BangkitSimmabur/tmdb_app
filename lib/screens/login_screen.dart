import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/reusable_components/common_components/button_full.dart';
import 'package:tmdb_app/reusable_components/common_components/common_app_bar.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';
import 'package:tmdb_app/reusable_components/common_components/outlined_form_field.dart';
import 'package:tmdb_app/services/auth_service.dart';
import 'package:tmdb_app/services/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthService _authService;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _locatorModel = GetIt.I<NavigationService>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (_locatorModel.navigatorKey.currentContext != null) return;
    _locatorModel.navigatorKey = _navigatorKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: Constant.colorBlack,
      appBar: const CommonAppBar(
        "Log in",
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 50,
            right: 50,
            top: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: OutlinedFormField(
                  inputController: _userNameController,
                  hintText: "User name",
                  prefixIcon: const Icon(FontAwesomeIcons.person),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: OutlinedFormField(
                  inputController: _passwordController,
                  hintText: "Password",
                  prefixIcon: const Icon(FontAwesomeIcons.lock),
                  inputType: TextInputType.text,
                  obscureText: _isPasswordVisible,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  height: 40,
                  child: CustomButtonFullBordered(
                    'Log in',
                    labelColor: Colors.black,
                    labelSize: 16,
                    labelWeight: FontWeight.w600,
                    buttonColor: Constant.colorWhite,
                    borderRadius: 4,
                    onClick: _onLogin,
                    btnBorderSide:
                        const BorderSide(width: 4, color: Constant.colorWhite),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CommonText(
                      "Don't have an account? ",
                      fontSize: Constant.fontSizeXS,
                      textColor: Constant.colorGreyText,
                    ),
                    GestureDetector(
                      onTap: _onNavigateRegister,
                      child: const CommonText(
                        "Register here",
                        textColor: Constant.colorDarkRed,
                        fontSize: Constant.fontSizeXS,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    PlatformHelper.showLoadingAlert(context, 'Login');

    HandlingServerLog result = await _authService.login(
      _userNameController.text,
      _passwordController.text,
    );

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    /// If failed logging in show error message
    if (result.success == false && mounted) {
      PlatformHelper.showErrorSnackbar(
          context, "Failed to login, please try again");
    }

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    return;
  }

  Future<void> _onNavigateRegister() async {
    final Uri urlParsed = Uri.parse(Constant.tmdbRegisterUrl);

    if (await canLaunchUrl(urlParsed)) {
      await launchUrl(urlParsed);
    } else {
      throw 'Could not launch url';
    }
    return;
  }
}
