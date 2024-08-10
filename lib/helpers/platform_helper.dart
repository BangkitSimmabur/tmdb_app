import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/services/navigation_service.dart';

/// Helper class to handle app snack bar message or transition
class PlatformHelper {
  /// Function used to navigate to different page
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

  /// Function used to pop/ transition to previous page with optional value sent to previous page
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

  /// Function to open snack bar with if an event/ process is successful
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
      backgroundColor: backgroundColor ?? Constant.colorWhite,
      messageColor: textColor ?? Constant.colorBlack,
      isDismissible: true,
      icon: Icon(
        Icons.done,
        color: textColor ?? Constant.colorBlack,
      ),
    ).show(context);
  }

  /// Function to open snack bar with if an event/ process is failed
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
      messageColor: textColor ?? Constant.colorBlack,
      backgroundColor: backgroundColor ?? Constant.colorWhite,
      icon: Icon(
        FontAwesomeIcons.circleExclamation,
        color: textColor ?? Constant.colorBlack,
      ),
      duration: Constant.defaultDurationSnackbar["duration"],
      animationDuration: Constant.defaultDurationSnackbar["animationDuration"]!,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  /// Function to show alert dialogue with loading indicator disabling app's action
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
                color: Constant.colorRed,
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
