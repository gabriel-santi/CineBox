import 'package:cinebox/ui/movies/commands/get_movies_by_genre_command.dart';
import 'package:cinebox/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesByGender extends ConsumerWidget {
  const MoviesByGender({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchedMovies = ref.watch(getMoviesByGenreCommandProvider);

    return searchedMovies.when(
      loading: () => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, st) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Text("Erro ao buscar filmes"),
        ),
      ),
      data: (data) => Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: MoviesBox(
          title: "Filmes encontrados",
          vertical: true,
          movies: data,
        ),
      ),
    );
  }
}
