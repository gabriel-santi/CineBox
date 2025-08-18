import 'dart:developer';

import 'package:cinebox/data/core/result/result.dart';
import 'package:cinebox/data/exceptions/data_exception.dart';
import 'package:cinebox/data/mappers/movie_mappers.dart';
import 'package:cinebox/data/services/tmdb/tmdb_service.dart';
import 'package:cinebox/domain/models/cast.dart';
import 'package:cinebox/domain/models/genre.dart';
import 'package:cinebox/domain/models/movie.dart';
import 'package:cinebox/domain/models/movie_detail.dart';
import 'package:dio/dio.dart';

import './tmdb_repository.dart';

class TmdbRepositoryImpl implements TmdbRepository {
  final TmdbService _tmdbService;

  TmdbRepositoryImpl({required TmdbService tmdbService}) : _tmdbService = tmdbService;

  @override
  Future<Result<List<Movie>>> getPopularMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getPopularMovies(
        language: language,
        page: page,
      );
      return Success(MovieMappers.mapToMovie(moviesData));
    } on DioException catch (e, st) {
      log("Erro ao buscar getPopularMovies", name: "TmdbRepository", error: e, stackTrace: st);
      return Failure(DataException("Erro ao buscar os filmes populares"));
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlayingMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getNowPlayingMovies(
        language: language,
        page: page,
      );
      return Success(MovieMappers.mapToMovie(moviesData));
    } on DioException catch (e, st) {
      log("Erro ao buscar getNowPlayingMovies", name: "TmdbRepository", error: e, stackTrace: st);
      return Failure(DataException("Erro ao buscar os filmes tocando agora"));
    }
  }

  @override
  Future<Result<List<Movie>>> getTopRatedMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getTopRatedMovies(
        language: language,
        page: page,
      );
      return Success(MovieMappers.mapToMovie(moviesData));
    } on DioException catch (e, st) {
      log("Erro ao buscar getTopRatedMovies", name: "TmdbRepository", error: e, stackTrace: st);
      return Failure(DataException("Erro ao buscar os filmes melhor avaliados"));
    }
  }

  @override
  Future<Result<List<Movie>>> getUpcomingMovies({
    String language = 'pt-BR',
    int page = 1,
  }) async {
    try {
      final moviesData = await _tmdbService.getUpcomingMovies(
        language: language,
        page: page,
      );
      return Success(MovieMappers.mapToMovie(moviesData));
    } on DioException catch (e, st) {
      log(
        "Erro ao buscar getUpcomingMovies",
        name: "TmdbRepository",
        error: e,
        stackTrace: st,
      );
      return Failure(DataException("Erro ao buscar filmes 'Em breve'"));
    }
  }

  @override
  Future<Result<List<Genre>>> getGenres() async {
    try {
      final data = await _tmdbService.getMoviesGenres();

      final genres = data.genres.map((g) => Genre(id: g.id, name: g.name)).toList();
      return Success(genres);
    } on DioException catch (e, st) {
      log(
        "Erro ao buscar gêneros",
        name: "TmdbRepository",
        error: e,
        stackTrace: st,
      );
      return Failure(DataException("Erro ao buscar gêneros"));
    }
  }

  @override
  Future<Result<List<Movie>>> getMoviesByGenre({required int genreId}) async {
    try {
      final data = await _tmdbService.discoverMovies(withGenres: genreId.toString());
      return Success(MovieMappers.mapToMovie(data));
    } on DioException catch (e, st) {
      log(
        "Erro ao buscar filmes por gênero",
        name: "TmdbRepository",
        error: e,
        stackTrace: st,
      );
      return Failure(DataException("Erro ao buscar filmes por gênero"));
    }
  }

  @override
  Future<Result<List<Movie>>> searchMovies({required String query}) async {
    try {
      final data = await _tmdbService.searchMovies(query: query);
      return Success(MovieMappers.mapToMovie(data));
    } on DioException catch (e, st) {
      log(
        "Erro ao buscar filmes por nome",
        name: "TmdbRepository",
        error: e,
        stackTrace: st,
      );
      return Failure(DataException("Erro ao buscar filmes por nome"));
    }
  }

  @override
  Future<Result<MovieDetail>> getMovieDetail(int movieId) async {
    try {
      final response = await _tmdbService.getMovieDetails(
        movieId,
        appendToResponse: 'credits,videos,recommendations,release_dates,images',
      );
      final movieDetail = MovieDetail(
        title: response.title,
        overview: response.overview,
        releaseDate: response.releaseDate,
        runtime: response.runtime,
        voteAverage: response.voteAverage,
        voteCount: response.voteCount,
        images: response.images.backdrops
            .map(
              (i) => 'https://image.tmdb.org/t/p/w343/${i.filePath}',
            )
            .toList(),
        cast: response.credits.cast
            .map(
              (c) => Cast(name: c.name, character: c.character, profilePath: c.profilePath),
            )
            .toList(),
        genres: response.genres
            .map(
              (g) => Genre(id: g.id, name: g.name),
            )
            .toList(),
        videos: response.videos.results.map((v) => v.key).toList(),
      );

      return Success(movieDetail);
    } on DioException catch (e, st) {
      log(
        "Erro ao buscar detalhes do filme",
        name: "TmdbRepository",
        error: e,
        stackTrace: st,
      );
      return Failure(DataException("Erro ao buscar detalhes do filme"));
    }
  }
}
