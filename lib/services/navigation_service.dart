import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Flushbar? flushBarNavigator;

  Widget? currentWidget;

  String? currentToken;

  Future<dynamic>? navigateNamedTo(String routeName) {
    if (navigatorKey.currentState == null) return null;

    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }
}
