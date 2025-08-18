import 'package:cinebox/ui/movie_detail/commands/get_movies_details_command.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_detail_view_model.g.dart';

class MovieDetailViewModel {
  final GetMoviesDetailsCommand _getMoviesDetailsCommand;

  MovieDetailViewModel({required GetMoviesDetailsCommand getMoviesDetailsCommand})
    : _getMoviesDetailsCommand = getMoviesDetailsCommand;

  Future<void> fetchMovieDetails(int movieId) async {
    _getMoviesDetailsCommand.execute(movieId);
  }
}

@riverpod
MovieDetailViewModel movieDetailViewModel(Ref ref) {
  return MovieDetailViewModel(getMoviesDetailsCommand: ref.read(getMoviesDetailsCommandProvider.notifier));
}
