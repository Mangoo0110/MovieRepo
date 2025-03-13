import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_colors.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        height: 165,
        width: 343,
        fit: BoxFit.cover,
        "https://djmmtgamechangerdoc.wordpress.com/wp-content/uploads/2022/02/uncharted-movie-cover.jpg?w=1200",
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 165,
            width: 343,
            decoration: BoxDecoration(
              color: AppColors.context(context).contentBoxGreyColor
            ),
            child: Center(child: Icon(Icons.image, size: 30,)),
          );
        },
      ),
    );
  }
}