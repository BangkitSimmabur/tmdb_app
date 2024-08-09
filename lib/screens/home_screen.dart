import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/components/common_components/common_app_bar.dart';
import 'package:tmdb_app/components/common_components/common_spinner.dart';
import 'package:tmdb_app/components/common_components/common_text.dart';
import 'package:tmdb_app/components/movie_card.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/screens/login_screen.dart';
import 'package:tmdb_app/screens/profile_screen.dart';
import 'package:tmdb_app/services/constant_service.dart';
import 'package:tmdb_app/services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieService _movieService;
  late ConstantService _constantService;
  bool nowPlayingLoading = true;
  bool popularLoading = true;
  List<Movie> nowPlaying = [];
  List<Movie> popularMovies = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, initDataState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _movieService = Provider.of<MovieService>(context);
    _constantService = Provider.of<ConstantService>(context);
    return Scaffold(
      appBar: const CommonAppBar(
        "home",
      ),
      backgroundColor: Constant.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CommonText(
                "Now Playing",
                fontSize: Constant.fontSizeLG,
                fontWeight: FontWeight.bold,
                textColor: Constant.white,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Constant.paddingMD),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: nowPlayingLoading
                      ? const CommonSpinner()
                      : CarouselSlider.builder(
                          itemCount:
                              nowPlaying.length < 6 ? nowPlaying.length : 6,
                          itemBuilder: (context, index, pageViewIndex) {
                            return MovieCard(
                              movie: nowPlaying[index],
                            );
                          },
                          options: CarouselOptions(
                            height: 300,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.55,
                            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                          ),
                        ),
                ),
              ),
              const CommonText(
                "Popular",
                fontSize: Constant.fontSizeLG,
                fontWeight: FontWeight.bold,
                textColor: Constant.white,
              ),
              popularLoading
                  ? const CommonSpinner()
                  : Column(
                      children: listPopularMovies,
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future initDataState() async {
    var fetchNowPlaying = await _movieService.getNowPlaying();
    setState(() {
      nowPlayingLoading = false;
      nowPlaying = fetchNowPlaying ?? [];
    });
    var fetchPopularMovies = await _movieService.getPopularMovies();
    setState(() {
      popularLoading = false;
      popularMovies = fetchPopularMovies ?? [];
    });
    return;
  }

  List<Widget> get listPopularMovies {
    List<Widget> listWidgets = [];
    popularMovies.asMap().forEach((int key, Movie movie) {
      listWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Constant.paddingMD),
          child: MovieCard(
            movie: movie,
          ),
        ),
      );
    });

    return listWidgets;
  }
}
