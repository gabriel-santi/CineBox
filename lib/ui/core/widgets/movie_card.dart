import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinebox/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieCard extends ConsumerStatefulWidget {
  const MovieCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieCardState();
}

class _MovieCardState extends ConsumerState<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 148,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRUGBvJEtlb5977KTrzddRUHGtIk4JR_a2AOXRa54frny5MTOPlHERr5epxbn_ydWPoU4e1PrgFkWE1oi0LavrvOxTVf4T9uC5AIrESe6TBwA',
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
                "Demon Slayer",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "2025",
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
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.lightGrey,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
