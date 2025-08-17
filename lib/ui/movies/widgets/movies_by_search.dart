import 'package:cinebox/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesBySearch extends ConsumerStatefulWidget {
  const MoviesBySearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesBySearchState();
}

class _MoviesBySearchState extends ConsumerState<MoviesBySearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: MoviesBox(
        title: "Filmes encontrados",
        vertical: true,
        movies: [],
      ),
    );
  }
}
