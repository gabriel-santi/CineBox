import 'package:cinebox/ui/movies/movies_view_model.dart';
import 'package:cinebox/ui/movies/widgets/genres_box.dart';
import 'package:cinebox/ui/movies/widgets/movies_appbar.dart';
import 'package:cinebox/ui/movies/widgets/movies_by_category.dart';
import 'package:cinebox/ui/movies/widgets/movies_by_gender.dart';
import 'package:cinebox/ui/movies/widgets/movies_by_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesScreen extends ConsumerStatefulWidget {
  const MoviesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends ConsumerState<MoviesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(moviesViewModelProvider.notifier).fetchMoviesByCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moviesViewModel = ref.watch(moviesViewModelProvider);

    return CustomScrollView(
      slivers: [
        MoviesAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 22),
            child: GenresBox(),
          ),
        ),
        SliverToBoxAdapter(
          child: switch (moviesViewModel) {
            MoviesViewEnum.byCategory => MoviesByCategory(),
            MoviesViewEnum.byGenre => MoviesByGender(),
            MoviesViewEnum.bySearch => MoviesBySearch(),
          },
        ),
      ],
    );
  }
}
