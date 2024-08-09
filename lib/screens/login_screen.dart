import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/components/common_components/button_full.dart';
import 'package:tmdb_app/components/common_components/common_app_bar.dart';
import 'package:tmdb_app/components/common_components/common_text.dart';
import 'package:tmdb_app/components/common_components/outlined_form_field.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/services/navigation_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _locatorModel = GetIt.I<NavigationService>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
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
    return Scaffold(
      backgroundColor: Constant.black,
      appBar: const CommonAppBar(
        "Log in",
      ),
      body: Form(
        child:  Padding(
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
                  inputController: _emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(FontAwesomeIcons.at),
                  inputType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: OutlinedFormField(
                  inputController: _passwordController,
                  hintText: "Password",
                  prefixIcon: const Icon(FontAwesomeIcons.lock),
                  inputType: TextInputType.text,
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
                    buttonColor: Constant.white,
                    borderRadius: 4,
                    onClick: () {
                      // _onLogin();
                    },
                    btnBorderSide:
                    const BorderSide(width: 4, color: Constant.white),
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
                      textColor: Constant.greyText,
                    ),
                    GestureDetector(
                      // onTap: _onNavigateRegister,
                      child: const CommonText(
                        "Register here",
                        textColor: Constant.darkRed,
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
}
