import 'package:cinebox/ui/movies/commands/get_movies_by_category_command.dart';
import 'package:cinebox/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesByCategory extends ConsumerWidget {
  const MoviesByCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(getMoviesByCategoryCommandProvider);

    return movies.when(
      loading: () => Padding(
        padding: EdgeInsetsGeometry.only(top: 20, bottom: 10),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Padding(
        padding: EdgeInsetsGeometry.only(top: 20, bottom: 10),
        child: Center(
          child: Text("Erro ao buscar filmes"),
        ),
      ),
      data: (data) {
        if (data == null) {
          return Center(
            child: Text("Nenhum filme encontrado"),
          );
        }

        return Padding(
          padding: EdgeInsets.only(top: 20, bottom: 100),
          child: Column(
            children: [
              MoviesBox(title: "Mais populares", movies: data.popular),
              MoviesBox(title: "Top Filmes", movies: data.topRated),
              MoviesBox(title: "Em cartaz", movies: data.nowPlaying),
              MoviesBox(title: "Em breve", movies: data.upcoming),
            ],
          ),
        );
      },
    );
  }
}
