import 'package:cinebox/data/models/favorite_movie_reponse.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'movies_service.g.dart';

@RestApi()
abstract class MoviesService {
  factory MoviesService(Dio dio, {String? baseUrl}) = _MoviesService;

  @GET('/favorite')
  Future<List<FavoriteMovieReponse>> getMyFavoritesMovies();
}
