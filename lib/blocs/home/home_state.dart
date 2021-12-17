import 'package:elopage_films/models/film.dart';

abstract class HomeState {
  final List<Film> filmsList;

  HomeState(this.filmsList);
}

class FilmsLoadingState extends HomeState {
  FilmsLoadingState(List<Film> filmsList) : super(filmsList);
}

class FilmsLoadState extends HomeState {
  FilmsLoadState(List<Film> filmsList) : super(filmsList);
}
