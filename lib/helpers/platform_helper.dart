import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/services/navigation_service.dart';

class PlatformHelper {
  static dynamic transitionToPage(
    BuildContext context,
    dynamic destination, {
    bool newPage = false,
  }) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    if (!newPage) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => destination));
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => destination));
    }
  }

  static dynamic backTransitionPage(
    BuildContext context, {
    dynamic value,
  }) {
    try {
      Navigator.pop(context, value);
      return;
    } catch (e) {
      try {
        var locatorModel = GetIt.I<NavigationService>();
        Navigator.pop(locatorModel.navigatorKey.currentContext!, value);
      } catch (_) {}
      return;
    }
  }

  static Future showSuccessSnackbar(
    BuildContext context,
    String content, {
    Color? textColor,
    Color? backgroundColor,
  }) async {
    String label = content;

    Flushbar(
      message: label,
      duration: Constant.defaultDurationSnackbar["duration"],
      animationDuration: Constant.defaultDurationSnackbar["animationDuration"]!,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: backgroundColor ?? Constant.white,
      messageColor: textColor ?? Constant.black,
      isDismissible: true,
      icon: const Icon(
        Icons.done,
        color: Colors.white,
      ),
    ).show(context);
  }

  static Future<Flushbar?> showErrorSnackbar(
    BuildContext context,
    String content, {
    Color? textColor,
    Color? backgroundColor,
  }) async {
    if (content.isEmpty) return null;

    String label = content;

    if (label.contains("input:")) {
      int i = label.indexOf(':');
      label = label.substring(i + 2);
      if (label.contains(":")) {
        int j = label.indexOf(':');
        label = label.substring(j + 2);
      }
    }

    return Flushbar(
      message: label,
      messageColor: textColor ?? Constant.black,
      backgroundColor: backgroundColor ?? Constant.white,
      icon: Icon(
        FontAwesomeIcons.circleExclamation,
        color: textColor ?? Constant.black,
      ),
      duration: Constant.defaultDurationSnackbar["duration"],
      animationDuration: Constant.defaultDurationSnackbar["animationDuration"]!,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  static Future<void>? showLoadingAlert(
    BuildContext context,
    String textInfo, {
    bool isShowed = true,
  }) {
    if (isShowed) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const SpinKitFadingCircle(
                color: Constant.lightBlue,
                size: 50,
              ),
              content: Text(
                textInfo,
                textAlign: TextAlign.center,
              ),
            );
          });
    }

    Navigator.pop(context);
    return null;
  }
}
