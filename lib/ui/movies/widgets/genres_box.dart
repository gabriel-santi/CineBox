import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:cinebox/ui/movies/commands/get_genres_command.dart';
import 'package:cinebox/ui/movies/movies_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenresBox extends ConsumerStatefulWidget {
  const GenresBox({super.key});

  @override
  ConsumerState<GenresBox> createState() => _GenresBoxState();
}

class _GenresBoxState extends ConsumerState<GenresBox> {
  final selectedGenre = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    final genres = ref.watch(getGenresCommandProvider);

    return genres.when(
      loading: () => Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, st) => Center(
        child: Text("Erro ao buscar gêneros"),
      ),
      data: (data) => SizedBox(
        height: 30,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 16),
          physics: BouncingScrollPhysics(),
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final genre = data[index];

            return InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                if (selectedGenre.value == genre.id) {
                  selectedGenre.value = 0;
                  ref.read(moviesViewModelProvider.notifier).fetchMoviesByCategory();
                  return;
                }
                selectedGenre.value = genre.id;
                ref.read(moviesViewModelProvider.notifier).fetchMoviesByGenre(genre.id);
              },
              child: ValueListenableBuilder(
                valueListenable: selectedGenre,
                builder: (_, value, _) {
                  return Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: value == genre.id ? AppColors.redColor : AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        genre.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
