import 'package:json_annotation/json_annotation.dart';

part 'favorite_movie_reponse.g.dart';

@JsonSerializable()
class FavoriteMovieReponse {
  final int movieId;
  final String posterUrl;
  final String title;
  final int year;

  FavoriteMovieReponse({required this.movieId, required this.posterUrl, required this.title, required this.year});

  factory FavoriteMovieReponse.fromJson(Map<String, dynamic> json) => _$FavoriteMovieReponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteMovieReponseToJson(this);
}
