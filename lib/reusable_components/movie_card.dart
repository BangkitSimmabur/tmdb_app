import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/screens/movie_detail.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard(
    this.movie, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Constant.borderRadiusSM),
      child: GestureDetector(
        onTap: () {
          PlatformHelper.transitionToPage(
            context,
            MovieDetail(movieId: movie.id!),
          );
        },
        child: Container(
          child: Image.network(
            "${Constant.imagePath500}/${movie.posterPath!}",
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
