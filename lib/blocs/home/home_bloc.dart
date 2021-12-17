import 'dart:async';
import 'package:elopage_films/blocs/home/home_event.dart';
import 'package:elopage_films/blocs/home/home_state.dart';
import 'package:elopage_films/core/api/api_client.dart';
import 'package:elopage_films/models/film.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final ApiClient _apiClient = ApiClient();

  Pages? page;

  HomeBloc() {
    _eventController.listen(listener);
  }

  final stateController = BehaviorSubject<HomeState>();

  Stream<HomeState> get filmsState => stateController.stream;

  Function(HomeState) get _setState => stateController.sink.add;

  final _eventController = BehaviorSubject<HomeEvent>();

  Stream<HomeEvent> get homeEventStream => _eventController.stream;

  Function(HomeEvent) get setEvent => _eventController.sink.add;

  Future<void> listener(HomeEvent event) async {
    if (event is FilmsLoadUpcomingEvent) {
      if (page != Pages.upComing) {
        _setState(FilmsLoadingState([]));
        List<Film> films = await loadUpcomingFilms();
        _setState(FilmsLoadState(films));
        page = Pages.upComing;
      }
    } else if (event is FilmsTopRatedEvent) {
      if (page != Pages.topRated) {
        _setState(FilmsLoadingState([]));
        List<Film> topRatedFilms = await loadTopRatedFilms();
        _setState(FilmsLoadState(topRatedFilms));
        page = Pages.topRated;
      }
    }
  }

  Future<List<Film>> loadUpcomingFilms() async {
    return await _apiClient.getUpcomingFilms();
  }

  Future<List<Film>> loadTopRatedFilms() async {
    return await _apiClient.getTopRatedFilms();
  }

  void dispose() {
    if (!stateController.isClosed) {
      stateController.close();
    }
  }
}

enum Pages { topRated, upComing }
