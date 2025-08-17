import 'package:cinebox/data/models/movie_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<MovieItem> results;

  MovieResponse({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
