import 'package:elopage_films/models/film.dart';

abstract class FilmDetailsState {
  final Film film;

  FilmDetailsState(this.film);
}

class FilmDetailsLoadingState extends FilmDetailsState {
  FilmDetailsLoadingState(Film film) : super(film);
}

class FilmDetailsLoadState extends FilmDetailsState {
  FilmDetailsLoadState(Film film) : super(film);
}
