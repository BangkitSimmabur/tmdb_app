import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
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
      } catch (e) {}
      return;
    }
  }

  static Future showSuccessSnackbar(
      BuildContext context,
      String content,
      ) async {
    String label = content;

    Flushbar(
      message: label,
      duration: Constant.defaultDurationSnackbar["duration"],
      animationDuration:
      Constant.defaultDurationSnackbar["animationDuration"]!,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      icon: const Icon(
        Icons.done,
        color: Colors.white,
      ),
    ).show(context);
  }

  static Future<Flushbar?> showErrorSnackbar(
      BuildContext context, String content) async {
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
      messageColor: const Color(0xffFF927A),
      backgroundColor: const Color(0xffFFF5F3),
      duration: Constant.defaultDurationSnackbar["duration"],
      animationDuration:
      Constant.defaultDurationSnackbar["animationDuration"]!,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  static Flushbar? showFloatingSnackbar(
      BuildContext? context,
      String content, {
        Color? color,
        FlushbarPosition position = FlushbarPosition.BOTTOM,
        IconData iconData = Icons.info,
        mainText = 'tutup',
        void Function(Flushbar<dynamic>)? onTap,
      }) {
    if (context == null) return null;

    var locatorModel = GetIt.I<NavigationService>();
    if (locatorModel.flushBarNavigator!.isShowing()) {
      locatorModel.flushBarNavigator?.dismiss();
    }

    if (content.contains("input:")) {
      var i = content.indexOf(':');
      content = content.substring(i + 2);
      if (content.contains(":")) {
        var j = content.indexOf(':');
        content = content.substring(j + 2);
      }
    }

    Flushbar? flush;
    var label = content;

    flush = Flushbar(
      duration: const Duration(seconds: 5),
      message: label,
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: position,
      animationDuration:
      Constant.defaultDurationSnackbar["animationDuration"]!,
      margin: EdgeInsets.all(
        Constant.defaultPaddingView,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(
          Constant.borderRadiusLG,
        ),
      ),
      onTap: onTap,
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      mainButton: TextButton(
        onPressed: () {
          flush?.dismiss(true);
        },
        child: Text(
          mainText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    )..show(context);
    locatorModel.flushBarNavigator = flush;

    return flush;
  }

  static Route routeAnimation(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
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
            return  AlertDialog(
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

