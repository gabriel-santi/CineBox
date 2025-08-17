import 'package:cinebox/data/repositories/auth/auth_repository.dart';
import 'package:cinebox/data/repositories/auth/auth_repository_impl.dart';
import 'package:cinebox/data/repositories/movies/movies_repository.dart';
import 'package:cinebox/data/repositories/movies/movies_repository_impl.dart';
import 'package:cinebox/data/repositories/tmdb/tmdb_repository.dart';
import 'package:cinebox/data/repositories/tmdb/tmdb_repository_impl.dart';
import 'package:cinebox/data/services/services_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repositories_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    googleSignInService: ref.read(googleSigninServiceProvider),
    localStorageService: ref.read(localStorageServiceProvider),
    authService: ref.read(authServiceProvider),
  );
}

@riverpod
TmdbRepository tmdbRepository(Ref ref) {
  return TmdbRepositoryImpl(tmdbService: ref.read(tmdbServiceProvider));
}

@riverpod
MoviesRepository moviesRepository(Ref ref) {
  return MoviesRepositoryImpl(moviesService: ref.read(moviesServiceProvider));
}
