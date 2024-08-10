import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/reusable_components/common_components/outline_button.dart';
import 'package:tmdb_app/reusable_components/movie_card.dart';

class HomeNowPlayingMovies extends StatelessWidget {
  final List<Movie> nowPlayingMovies;
  final Future<void> Function(int?) onAddWatchList;
  final Future<void> Function(int?) onAddFavorite;
  final Future<void> Function(String) onSaveImage;

  const HomeNowPlayingMovies(
    this.nowPlayingMovies, {
    super.key,
    required this.onAddWatchList,
    required this.onAddFavorite,
    required this.onSaveImage,
  });
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: nowPlayingMovies.length < 6 ? nowPlayingMovies.length : 6,
      itemBuilder: (context, index, pageViewIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(Constant.borderRadiusSM),
          child: SizedBox(
            height: 300,
            width: 210,
            child: Stack(
              children: [
                SizedBox(
                  height: 300,
                  width: 210,
                  child: MovieCard(
                    nowPlayingMovies[index],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: Constant.paddingSM,
                      right: Constant.paddingSM,
                    ),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Constant.colorWhiteOpacity75,
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Constant.colorRed,
                      ),
                      onPressed: () =>
                          onAddFavorite(nowPlayingMovies[index].id),
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
                            icon: FontAwesomeIcons.plus,
                            onTap: () =>
                                onAddWatchList(nowPlayingMovies[index].id),
                            buttonColor: Constant.colorBlackOpacity75,
                            borderColor: Constant.colorWhiteOpacity75,
                            labelColor: Constant.colorWhiteOpacity75,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomOutlinedButton(
                            icon: FontAwesomeIcons.download,
                            onTap: () {
                              onSaveImage(
                                  "${Constant.imagePathOriginal}/${nowPlayingMovies[index].posterPath!}");
                            },
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
        );
      },
      options: CarouselOptions(
        height: 300,
        clipBehavior: Clip.none,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.55,
        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
        autoPlayAnimationDuration: const Duration(seconds: 10),
      ),
    );
  }
}
