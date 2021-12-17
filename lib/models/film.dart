class Film {
  final int id;
  final String title;
  final String overView;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  Film({
    required this.id,
    required this.title,
    required this.overView,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  static Film empty() {
    return Film(id: 0, title: "", overView: "", posterPath: "", releaseDate: "", voteAverage: 0);
  }

  static Film fromJson(Map<String, dynamic> json) {
    return Film(
      id: json["id"],
      title: json["title"],
      overView: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"] is int ? json["vote_average"].toDouble() : json["vote_average"],
    );
  }
}
