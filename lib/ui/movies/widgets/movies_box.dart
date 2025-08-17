import 'package:cinebox/ui/core/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesBox extends ConsumerStatefulWidget {
  final String title;
  final bool vertical;
  const MoviesBox({
    super.key,
    required this.title,
    this.vertical = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesBoxState();
}

class _MoviesBoxState extends ConsumerState<MoviesBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 24),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
        ),
        Visibility(
          visible: !widget.vertical,
          replacement: Center(
            child: Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                MovieCard(),
                MovieCard(),
                MovieCard(),
                MovieCard(),
                MovieCard(),
                MovieCard(),
                MovieCard(),
              ],
            ),
          ),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 253,
            child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.only(left: 20),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: MovieCard(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
