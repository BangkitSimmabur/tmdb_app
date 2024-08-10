import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

/// A service class to handle key and navigation of the app
class NavigationService {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Flushbar? flushBarNavigator;

  Widget? currentWidget;

  Future<dynamic>? navigateNamedTo(String routeName) {
    if (navigatorKey.currentState == null) return null;

    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }
}
