import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:cinebox/ui/core/themes/text_styles.dart';
import 'package:cinebox/ui/core/widgets/loader_messages.dart';
import 'package:cinebox/ui/movie_detail/commands/get_movies_details_command.dart';
import 'package:cinebox/ui/movie_detail/movie_detail_view_model.dart';
import 'package:cinebox/ui/movie_detail/widgets/cast_box.dart';
import 'package:cinebox/ui/movie_detail/widgets/movie_trailer.dart';
import 'package:cinebox/ui/movie_detail/widgets/rating_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  const MovieDetailScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> with LoaderAndMessage {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieId = ModalRoute.of(context)?.settings.arguments as int?;
      if (movieId == null) {
        showErrorSnackbar("Filme não encontrado");
        return;
      }
      ref.read(movieDetailViewModelProvider).fetchMovieDetails(movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movieDetail = ref.watch(getMoviesDetailsCommandProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
      ),
      body: movieDetail.when(
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
        error: (e, st) => Center(
          child: Text("Erro ao carregar detalhes do filme"),
        ),
        data: (data) {
          if (data == null) {
            return Center(
              child: Text("Filme não encontrado!"),
            );
          }

          final hoursRuntime = data.runtime ~/ 60;
          final minutesRuntime = data.runtime % 60;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 278,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: data.images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CachedNetworkImage(
                          imageUrl: data.images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 150,
                            color: AppColors.lightGrey,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) {
                            return Container(
                              width: 150,
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
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        data.title,
                        style: AppTextStyles.titleLarge,
                      ),
                      RatingStars(
                        starCount: 5,
                        starColor: AppColors.yellow,
                        starSize: 14,
                        valueLabelVisibility: false,
                        value: data.voteAverage / 2,
                      ),
                      Text(
                        data.genres.map((g) => g.name).join(", "),
                        style: AppTextStyles.lightGreyRegular,
                      ),
                      Text(
                        "${DateTime.parse(data.releaseDate).year} (USA) | ${hoursRuntime}h$minutesRuntime",
                        style: AppTextStyles.regularSmall,
                      ),
                      Text(
                        data.overview,
                        style: AppTextStyles.regularSmall,
                      ),
                      CastBox(
                        movieDetail: data,
                      ),
                      if (data.videos.isNotEmpty) MovieTrailer(videoId: data.videos.first),
                      const SizedBox(height: 30),
                      RatingPanel(
                        voteAverage: data.voteAverage,
                        voteCount: data.voteCount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
