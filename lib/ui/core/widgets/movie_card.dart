import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinebox/ui/core/commands/favorite_movie_command.dart';
import 'package:cinebox/ui/core/commands/remove_favorite_movie_command.dart';
import 'package:cinebox/ui/core/commands/save_favorite_movie_command.dart';
import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:cinebox/ui/core/widgets/loader_messages.dart';
import 'package:cinebox/ui/core/widgets/movie_card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieCard extends ConsumerStatefulWidget {
  final int id;
  final String title;
  final int year;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;

  const MovieCard({
    super.key,
    required this.id,
    required this.title,
    required this.year,
    required this.imageUrl,
    required this.isFavorite,
    this.onFavoriteTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieCardState();
}

class _MovieCardState extends ConsumerState<MovieCard> with LoaderAndMessage {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoriteMovieCommandProvider(widget.id).notifier).setFavorite(widget.isFavorite);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(favoriteMovieCommandProvider(widget.id));

    ref.listen(
      saveFavoriteMovieCommandProvider(widget.key!, widget.id),
      (_, state) {
        state.whenOrNull(
          error: (e, st) {
            showErrorSnackbar("Ops! Não foi possível salvar seu filme como favorito");
          },
        );
      },
    );
    ref.listen(
      removeFavoriteMovieCommandProvider(widget.key!, widget.id),
      (_, state) {
        state.whenOrNull(
          error: (e, st) {
            showErrorSnackbar("Ops! Não foi remover o filme dos favoritos");
          },
        );
      },
    );

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/movie_details", arguments: widget.id);
      },
      child: Stack(
        children: [
          SizedBox(
            width: 148,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 148,
                      height: 184,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Container(
                      width: 148,
                      height: 184,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.lightGrey,
                      ),
                      child: Center(
                        child: Icon(Icons.broken_image, color: AppColors.darkGrey),
                      ),
                    );
                  },
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.year.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 50,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(20),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed:
                      widget.onFavoriteTap ??
                      () {
                        ref
                            .read(movieCardViewModelProvider(widget.key!, widget.id).notifier)
                            .addOrRemoveFavorite(
                              id: widget.id,
                              title: widget.title,
                              posterPath: widget.imageUrl,
                              year: widget.year,
                              favorite: !isFavorite,
                            );
                      },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.redColor : AppColors.lightGrey,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
