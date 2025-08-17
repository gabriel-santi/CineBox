// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_movie_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteMovieReponse _$FavoriteMovieReponseFromJson(
  Map<String, dynamic> json,
) => FavoriteMovieReponse(
  movieId: (json['movie_id'] as num).toInt(),
  posterUrl: json['poster_url'] as String,
  title: json['title'] as String,
  year: (json['year'] as num).toInt(),
);

Map<String, dynamic> _$FavoriteMovieReponseToJson(
  FavoriteMovieReponse instance,
) => <String, dynamic>{
  'movie_id': instance.movieId,
  'poster_url': instance.posterUrl,
  'title': instance.title,
  'year': instance.year,
};
