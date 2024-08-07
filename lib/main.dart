import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/screens/home_screen.dart';
import 'package:tmdb_app/services/constant_service.dart';
import 'package:tmdb_app/services/movie_service.dart';
import 'package:tmdb_app/services/navigation_service.dart';
import 'package:tmdb_app/services/network_service.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

void main() {
  setupLocator();
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(MyApp());
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

  final _constantService = ConstantService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConstantService>(
          create: (_) => ConstantService(),
        ),
        ChangeNotifierProvider<NetworkService>(
          create: (_) => NetworkService(_constantService),
        ),
        ChangeNotifierProvider<MovieService>(
          create: (_) => MovieService(_constantService),
        ),
      ],
      child: RefreshConfiguration(
        headerBuilder: () => const MaterialClassicHeader(),
        footerBuilder: () => const ClassicFooter(
          loadStyle: LoadStyle.ShowAlways,
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const HomeScreen(),
    // );
  }
}
