import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/screens/home/home_screen.dart';
import 'package:tmdb_app/services/auth_service.dart';
import 'package:tmdb_app/services/movie_service.dart';
import 'package:tmdb_app/services/navigation_service.dart';
import 'package:tmdb_app/services/network_service.dart';

void main() {
  setupLocator();
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      );
      runApp(const MyApp());
    },
    (error, stackTrace) async {
      if (kDebugMode) {
        print('error$stackTrace');
      }
    },
  );
}

void setupLocator() {
  GetIt.I.registerLazySingleton<NavigationService>(() => NavigationService());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NetworkService>(
          create: (_) => NetworkService(),
        ),
        ChangeNotifierProvider<MovieService>(
          create: (_) => MovieService(),
        ),
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        title: 'TMDB APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: (route) => _routeMap[route.name](
          route.arguments,
        ),
      ),
    );
  }

  Map get _routeMap {
    return {
      '/': (dynamic data) => MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
    };
  }
}
