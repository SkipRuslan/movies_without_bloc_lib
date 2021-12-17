import 'package:elopage_films/resources/app_routes.dart';
import 'package:elopage_films/screens/film_details_screen.dart';
import 'package:elopage_films/screens/home_screen.dart';
import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.homeScreenRoute,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    Widget screen = const HomeScreen();
    switch (settings.name) {
      case AppRoutes.homeScreenRoute:
        screen = const HomeScreen();
        break;
      case AppRoutes.filmDetailsScreenRoute:
        int filmId = settings.arguments as int;
        screen = FilmDetailsScreen(
          id: filmId,
        );
        break;
    }
    return MaterialPageRoute(
      builder: (_) => screen,
    );
  }
}
