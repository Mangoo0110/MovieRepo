import 'package:movie_repo/features/movieshow/domain/entities/show.dart';

class ShowModel extends Show {
  ShowModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterPath,
    required super.releaseDate, 
    required super.durationInSeconds,
  });

  factory ShowModel.fromMap(Map<String, dynamic> map) {
    return ShowModel(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      releaseDate: (map['release_date']),
      durationInSeconds: (map['durationInSeconds']),
    );
  }
}
