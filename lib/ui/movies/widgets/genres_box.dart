import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenresBox extends ConsumerStatefulWidget {
  const GenresBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenresBoxState();
}

class _GenresBoxState extends ConsumerState<GenresBox> {
  final selectedGenre = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16),
        physics: BouncingScrollPhysics(),
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              selectedGenre.value = index;
            },
            child: ValueListenableBuilder(
              valueListenable: selectedGenre,
              builder: (_, value, _) {
                return Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: value == index ? AppColors.redColor : AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Item $index",
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
    );
  }
}
