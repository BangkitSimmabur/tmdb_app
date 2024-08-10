import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/reusable_components/common_components/common_app_bar.dart';
import 'package:tmdb_app/reusable_components/common_components/common_spinner.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';
import 'package:tmdb_app/screens/home/now_playing_component.dart';
import 'package:tmdb_app/screens/home/popular_component.dart';
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
  List<Movie> nowPlayingMovies = [];
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
      appBar: CommonAppBar(
        "Home",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: Constant.paddingXXS),
            child: IconButton(
              onPressed: _onNavigateToProfile,
              icon: const Icon(Icons.person),
              color: Constant.colorWhite,
            ),
          ),
        ],
      ),
      backgroundColor: Constant.colorBlack,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CommonText(
                "Now Playing",
                fontSize: Constant.fontSizeLG,
                fontWeight: FontWeight.bold,
                textColor: Constant.colorWhite,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Constant.paddingMD),
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: nowPlayingLoading
                      ? const CommonSpinner()
                      : HomeNowPlayingMovies(
                          nowPlayingMovies,
                          onAddFavorite: onAddFavoriteMovie,
                          onAddWatchList: onAddWatchList,
                        ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: Constant.paddingSM),
                child: Divider(
                  color: Constant.colorDarkRed,
                ),
              ),
              const CommonText(
                "Popular",
                fontSize: Constant.fontSizeLG,
                fontWeight: FontWeight.bold,
                textColor: Constant.colorWhite,
              ),
              popularLoading
                  ? const CommonSpinner()
                  : HomePopularMovies(
                      popularMovies,
                      onAddFavorite: onAddFavoriteMovie,
                      onAddWatchList: onAddWatchList,
                    ),
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
      nowPlayingMovies = fetchNowPlaying ?? [];
    });
    var fetchPopularMovies = await _movieService.getPopularMovies();
    setState(() {
      popularLoading = false;
      popularMovies = fetchPopularMovies ?? [];
    });
    return;
  }

  void _onNavigateToProfile() {
    if (_constantService.sessionID != null && _constantService.userID != null) {
      PlatformHelper.transitionToPage(context, const ProfileScreen());
      return;
    }
    PlatformHelper.transitionToPage(context, const LoginScreen());
  }

  Future<void> onAddFavoriteMovie(int? id) async {
    if (_checkLogin() == false) {
      PlatformHelper.showErrorSnackbar(
          context, "You need to login before adding to favorites");
      return;
    }
    PlatformHelper.showLoadingAlert(context, 'Adding movie to favorites');

    HandlingServerLog result = await _movieService.addToFavorites(id!, true);

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    if (result.success == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Failed to add movie to favorites")
          : {};
      return;
    }

    if (result.success == true && result.status == 12) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Movie is already in your favorites")
          : {};
      return;
    }

    if (result.success == true && result.status == 1) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Movie is added to favorites")
          : {};
      return;
    }

    return;
  }

  Future<void> onAddWatchList(int? id) async {
    if (_checkLogin() == false) {
      PlatformHelper.showErrorSnackbar(
          context, "You need to login before adding to your watch list");
      return;
    }
    PlatformHelper.showLoadingAlert(context, 'Adding movie to watch list');

    HandlingServerLog result = await _movieService.onAddToWatchList(id!, true);

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    if (result.success == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Failed to add movie to your watch list")
          : {};
      return;
    }

    if (result.success == true && result.status == 12) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Movie is already in your watch list")
          : {};
      return;
    }

    if (result.success == true && result.status == 1) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Movie is added to your watch list")
          : {};
      return;
    }

    return;
  }

  bool _checkLogin() {
    if (_constantService.userID == null || _constantService.sessionID == null) {
      return false;
    }
    return true;
  }
}
