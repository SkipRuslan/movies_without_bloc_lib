import 'package:dio/dio.dart';
import 'package:elopage_films/models/film.dart';

class ApiClient {
  Dio dio = Dio();
  static const String _baseUrl = "https://api.themoviedb.org";


  Future<List<Film>> getUpcomingFilms() async {
    final response = await dio.get("$_baseUrl/3/movie/upcoming?api_key=212ba72a80152a5f821e0d83ca865680&language=en-US");
    int? code = response.statusCode;
    if (code == 200) {
      List<Film> films = [];
      final List<dynamic> data = response.data["results"];
      for (int i = 1; i < data.length; i++) {
        films.add(Film.fromJson(data[i]));
      }
      return films;
    } else {
      throw Exception(response.data["message"]);
    }
  }

  Future<List<Film>> getTopRatedFilms() async {
    final response =
        await dio.get("$_baseUrl/3/movie/top_rated?api_key=212ba72a80152a5f821e0d83ca865680&language=en-US");
    int? code = response.statusCode;
    if (code == 200) {
      List<Film> films = [];
      final List<dynamic> data = response.data["results"];
      for (int i = 1; i < data.length; i++) {
        films.add(Film.fromJson(data[i]));
      }
      return films;
    } else {
      throw Exception(response.data["message"]);
    }
  }

  Future<Film> getFilmById(int id) async {
    final response = await dio.get("$_baseUrl/3/movie/$id?api_key=212ba72a80152a5f821e0d83ca865680&language=en-US");
    int? code = response.statusCode;
    if (code == 200) {
      final Map<String, dynamic> data = response.data;
      return Film.fromJson(data);
    } else {
      throw Exception(response.data["message"]);
    }
  }
}
