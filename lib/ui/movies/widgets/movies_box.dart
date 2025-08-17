import 'package:cinebox/domain/models/movie.dart';
import 'package:cinebox/ui/core/widgets/movie_card.dart';
import 'package:flutter/material.dart';

class MoviesBox extends StatelessWidget {
  final String title;
  final bool vertical;
  final List<Movie> movies;
  const MoviesBox({
    super.key,
    required this.title,
    this.vertical = false,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 24),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        Visibility(
          visible: !vertical,
          replacement: Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                for (var movie in movies)
                  MovieCard(
                    id: movie.id,
                    title: movie.title,
                    year: movie.realeaseDate != null && movie.realeaseDate!.isNotEmpty
                        ? DateTime.parse(movie.realeaseDate!).year
                        : DateTime.now().year,
                    imageUrl: "https://images.tmdb.org/t/p/w154/${movie.posterPath}",
                    isFavorite: movie.isFavorite,
                  ),
              ],
            ),
          ),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 253,
            child: ListView.builder(
              itemCount: movies.length,
              padding: EdgeInsets.only(left: 20),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: MovieCard(
                    key: UniqueKey(),
                    id: movie.id,
                    title: movie.title,
                    year: movie.realeaseDate != null && movie.realeaseDate!.isNotEmpty
                        ? DateTime.parse(movie.realeaseDate!).year
                        : DateTime.now().year,
                    imageUrl: "https://images.tmdb.org/t/p/w154/${movie.posterPath}",
                    isFavorite: movie.isFavorite,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
