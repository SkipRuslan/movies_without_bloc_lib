abstract class FilmDetailsEvent {
  final int id;

  FilmDetailsEvent(this.id);
}

class FilmDetailsLoadEvent implements FilmDetailsEvent {
  @override
  final int id;

  FilmDetailsLoadEvent(this.id);
}
