import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/screens/home_screen.dart';
import 'package:tmdb_app/services/navigation_service.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

void setupLocator() {
  GetIt.I.registerLazySingleton<NavigationService>(() => NavigationService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

