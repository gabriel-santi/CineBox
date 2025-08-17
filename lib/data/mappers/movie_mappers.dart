import 'package:cinebox/data/models/movie_response.dart';
import 'package:cinebox/domain/models/movie.dart';

class MovieMappers {
  static List<Movie> mapToMovie(MovieResponse movieResponse) {
    return movieResponse.results
        .map(
          (response) => Movie(
            id: response.id,
            title: response.title,
            overview: response.overview,
            genreIds: response.genreIds ?? [],
            backdropPath: response.backdropPath,
            posterPath: response.posterPath,
            realeaseDate: response.releaseDate,
            voteAverage: response.voteAverage,
          ),
        )
        .toList();
  }
}
