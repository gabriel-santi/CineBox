import 'package:cinebox/data/core/result/result.dart';
import 'package:cinebox/data/repositories/repositories_providers.dart';
import 'package:cinebox/domain/models/movie_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movies_details_command.g.dart';

@riverpod
class GetMoviesDetailsCommand extends _$GetMoviesDetailsCommand {
  @override
  AsyncValue<MovieDetail?> build() => AsyncLoading();

  Future<void> execute(int movieId) async {
    final result = await ref.read(tmdbRepositoryProvider).getMovieDetail(movieId);

    state = switch (result) {
      Success(:final value) => AsyncData(value),
      Failure() => AsyncError("Erro ao buscar detalhes do filme", StackTrace.current),
    };
  }
}
