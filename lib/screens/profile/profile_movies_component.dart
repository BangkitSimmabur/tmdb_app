import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/reusable_components/common_components/common_spinner.dart';
import 'package:tmdb_app/reusable_components/movie_card.dart';

/// Custom movie list to display watch list or favorite list
class ProfileMovieComponent extends StatelessWidget {
  /// The movie list to be displayed either it is favorite list or watch list
  final List<Movie> movies;

  /// The loading state when fetching data from api
  final bool isLoading;

  /// The list scroll controller
  final ScrollController scrollController;

  /// Action when the trash icon button pressed
  final Future<void> Function(int?) onRemoveFromList;

  const ProfileMovieComponent({
    super.key,
    required this.isLoading,
    required this.scrollController,
    required this.movies,
    required this.onRemoveFromList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: isLoading
          ? const CommonSpinner()
          : ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              key: UniqueKey(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(
                    Constant.paddingMD,
                  ),
                  child: SizedBox(
                    height: 368,
                    width: 245,
                    child: Stack(
                      children: [
                        MovieCard(movies[index]),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: Constant.colorWhiteOpacity75,
                            ),
                            icon: const Icon(
                              FontAwesomeIcons.trash,
                              color: Constant.colorBlackOpacity75,
                            ),
                            onPressed: () {
                              onRemoveFromList(movies[index].id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: movies.length,
            ),
    );
  }
}
