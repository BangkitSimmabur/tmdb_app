import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/reusable_components/common_components/outline_button.dart';
import 'package:tmdb_app/reusable_components/movie_card.dart';

/// Popular movie list displayed in vertical scrollable posters
class HomePopularMovies extends StatelessWidget {
  /// The movie list fetched from tmdb api
  final List<Movie> popularMovies;

  /// Action when the watch list button pressed
  final Future<void> Function(int?) onAddWatchList;

  /// Action when the icon favorite button pressed
  final Future<void> Function(int?) onAddFavorite;

  /// Action when the download button pressed
  final Future<void> Function(String) onSaveImage;

  const HomePopularMovies(
    this.popularMovies, {
    super.key,
    required this.onAddWatchList,
    required this.onAddFavorite,
    required this.onSaveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: listPopularMovies(context),
    );
  }

  List<Widget> listPopularMovies(context) {
    List<Widget> listWidgets = [];
    popularMovies.asMap().forEach((int key, Movie movie) {
      listWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Constant.paddingMD,
          ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 2 / 3,
            width: MediaQuery.sizeOf(context).width - (Constant.paddingSM * 2),
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 2 / 3,
                  width: MediaQuery.sizeOf(context).width -
                      (Constant.paddingSM * 2),
                  child: MovieCard(
                    movie,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Constant.paddingSM,
                    right: Constant.paddingSM,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Constant.colorWhiteOpacity75,
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Constant.colorRed,
                      ),
                      onPressed: () => onAddFavorite(movie.id),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomOutlinedButton(
                            labelText: "Watch List",
                            icon: FontAwesomeIcons.plus,
                            onTap: () => onAddWatchList(movie.id),
                            buttonColor: Constant.colorBlackOpacity50,
                            borderColor: Constant.colorWhiteOpacity75,
                            labelColor: Constant.colorWhiteOpacity75,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomOutlinedButton(
                            labelText: "Image",
                            icon: FontAwesomeIcons.download,
                            onTap: () => onSaveImage(
                                "${Constant.imagePathOriginal}/${movie.posterPath}"),
                            buttonColor: Constant.colorBlackOpacity50,
                            borderColor: Constant.colorWhiteOpacity75,
                            labelColor: Constant.colorWhiteOpacity75,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    return listWidgets;
  }
}
