import 'package:cinebox/domain/models/favorite_movie.dart';
import 'package:cinebox/ui/core/widgets/loader_messages.dart';
import 'package:cinebox/ui/core/widgets/movie_card.dart';
import 'package:cinebox/ui/favorites/commands/get_favorites_command.dart';
import 'package:cinebox/ui/favorites/favorites_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> with LoaderAndMessage {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoritesViewModelProvider).fetchFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(getFavoritesCommandProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus favoritos"),
      ),
      body: favoritesMovies.when(
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, st) => Center(
          child: Text("Erro ao buscar filmes"),
        ),
        data: (data) {
          if (data.isEmpty) {
            return Center(
              child: Text("Nenhum filme favoritado"),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsetsGeometry.only(
                  bottom: 100,
                  left: 16,
                  right: 16,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 148,
                    mainAxisExtent: 268,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final FavoriteMovie(:id, :title, :year, posterPath: imageUrl) = data[index];

                      return Padding(
                        padding: EdgeInsetsGeometry.all(8),
                        child: MovieCard(
                          key: UniqueKey(),
                          id: id,
                          title: title,
                          year: year,
                          imageUrl: imageUrl,
                          isFavorite: true,
                          onFavoriteTap: () async {
                            showLoader();
                            await ref.read(favoritesViewModelProvider).removeFavoriteMovie(id);
                            hideLoader();
                          },
                        ),
                      );
                    },
                    childCount: data.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
