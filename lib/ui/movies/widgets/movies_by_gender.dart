import 'package:cinebox/ui/movies/widgets/movies_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesByGender extends ConsumerStatefulWidget {
  const MoviesByGender({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoviesByGenderState();
}

class _MoviesByGenderState extends ConsumerState<MoviesByGender> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: MoviesBox(
        title: "Filmes encontrados",
        vertical: true,
      ),
    );
  }
}
