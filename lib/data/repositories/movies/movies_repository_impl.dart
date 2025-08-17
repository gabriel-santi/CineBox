import 'dart:developer';

import 'package:cinebox/data/core/result/result.dart';
import 'package:cinebox/data/exceptions/data_exception.dart';
import 'package:cinebox/data/models/save_favorite_movie.dart';
import 'package:cinebox/data/services/movies/movies_service.dart';
import 'package:cinebox/domain/models/favorite_movie.dart';
import 'package:dio/dio.dart';

import './movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesService _moviesService;

  MoviesRepositoryImpl({required MoviesService moviesService}) : _moviesService = moviesService;

  @override
  Future<Result<List<FavoriteMovie>>> getMyFavoritesMovies() async {
    try {
      final response = await _moviesService.getMyFavoritesMovies();
      final favorites = response
          .map(
            (f) => FavoriteMovie(
              id: f.movieId,
              title: f.title,
              posterPath: f.posterUrl,
              year: f.year,
            ),
          )
          .toList();
      return Success(favorites);
    } on DioException catch (e, st) {
      log("Erro ao buscar os filmes favoritos", name: "MoviesRepository", error: e, stackTrace: st);
      return Failure(DataException("Erro ao buscar os filmes favoritos"));
    }
  }

  @override
  Future<Result<Unit>> deleteFavoriteMovie(int movieId) async {
    try {
      await _moviesService.deleteFavoriteMovie(movieId);
      return successOfUnit();
    } on DioException catch (e, st) {
      log("Erro ao deletar favorito", name: "MoviesRepository", error: e, stackTrace: st);
      return Failure(DataException("Erro ao deletar favorito"));
    }
  }

  @override
  Future<Result<Unit>> saveFavoriteMovie(FavoriteMovie favoriteMovie) async {
    try {
      final SaveFavoriteMovie saveFavoriteMovie = SaveFavoriteMovie(
        movieId: favoriteMovie.id,
        posterUrl: favoriteMovie.posterPath,
        title: favoriteMovie.title,
        year: favoriteMovie.year,
      );
      await _moviesService.saveFavoriteMovie(saveFavoriteMovie);
      return successOfUnit();
    } on DioException catch (e, st) {
      log("Erro ao salvar favorito", name: "MoviesRepository", error: e, stackTrace: st);
      return Failure(DataException("Erro ao salvar favorito"));
    }
  }
}
