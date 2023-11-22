// class NowPlayingModel {
//   List<Movie> results;

//   NowPlayingModel({
//     required this.results,
//   });

//   factory NowPlayingModel.fromJson(Map<String, dynamic> json) {
//     return NowPlayingModel(
//       results: List<Movie>.from(
//           json['results'].map((result) => Movie.fromJson(result))),
//     );
//   }
// }

// class Dates {
//   String maximum;
//   String minimum;

//   Dates({
//     required this.maximum,
//     required this.minimum,
//   });

//   factory Dates.fromJson(Map<String, dynamic> json) {
//     return Dates(
//       maximum: json['maximum'],
//       minimum: json['minimum'],
//     );
//   }
// }

class NowPlayingModel {
  bool adult;
  String backdropPath;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  NowPlayingModel({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) {
    return NowPlayingModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
    );
  }
}
