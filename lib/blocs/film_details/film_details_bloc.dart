import 'dart:async';
import 'package:elopage_films/core/api/api_client.dart';
import 'package:elopage_films/models/film.dart';
import 'package:rxdart/rxdart.dart';
import 'film_details_event.dart';
import 'film_details_state.dart';

class FilmDetailsBloc {
  final ApiClient _apiClient = ApiClient();

  FilmDetailsBloc() {
    _eventController.listen(listener);
  }

  final stateController = BehaviorSubject<FilmDetailsState>();

  Stream<FilmDetailsState> get filmsState => stateController.stream;

  Function(FilmDetailsState) get _setState => stateController.sink.add;

  final _eventController = BehaviorSubject<FilmDetailsEvent>();

  Stream<FilmDetailsEvent> get homeEventStream => _eventController.stream;

  Function(FilmDetailsEvent) get setEvent => _eventController.sink.add;

  Future<void> listener(FilmDetailsEvent event) async {
    if (event is FilmDetailsLoadEvent) {
      _setState(FilmDetailsLoadingState(Film.empty()));
      Film film = await loadFilmById(event.id);
      _setState(FilmDetailsLoadState(film));
    }
  }

  Future<Film> loadFilmById(int id) async {
    return await _apiClient.getFilmById(id);
  }

  void dispose() {
    if (!stateController.isClosed) {
      stateController.close();
    }
  }
}
