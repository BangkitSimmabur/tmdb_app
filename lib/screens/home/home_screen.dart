import 'dart:async';
import 'package:fl_downloader/fl_downloader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/helpers/secure_storage_helper.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/reusable_components/common_components/common_app_bar.dart';
import 'package:tmdb_app/reusable_components/common_components/common_spinner.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';
import 'package:tmdb_app/screens/home/now_playing_component.dart';
import 'package:tmdb_app/screens/home/popular_component.dart';
import 'package:tmdb_app/screens/login_screen.dart';
import 'package:tmdb_app/screens/profile/profile_screen.dart';
import 'package:tmdb_app/services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieService _movieService;
  bool nowPlayingLoading = true;
  bool popularLoading = true;
  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  late StreamSubscription progressStream;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, initDataState);

    FlDownloader.initialize();

    // Event handler based on the status of image downloader
    progressStream = FlDownloader.progressStream.listen(
      (event) {
        if (event.status == DownloadStatus.successful) {
          PlatformHelper.showSuccessSnackbar(context, "Image downloaded");
        } else if (event.status == DownloadStatus.running) {
          PlatformHelper.showSuccessSnackbar(context, "Downloading image");
        } else if (event.status == DownloadStatus.failed) {
          PlatformHelper.showSuccessSnackbar(
              context, "Failed to download image");
        }
      },
    );
  }

  @override
  void dispose() {
    progressStream.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _movieService = Provider.of<MovieService>(context);
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
          padding: const EdgeInsets.all(Constant.paddingXS),
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
                          onSaveImage: onDownloadImage,
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
                      onSaveImage: onDownloadImage,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  /// Function ran when the page was opened fetching movies currently playing and popular movies
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

  /// Action called when the profile icon button pressed
  /// User will transition to Log in page if user haven't logged in
  /// User will transition to Profile page if user already logged in
  void _onNavigateToProfile() async {
    if (await _checkLogin()) {
      mounted
          ? PlatformHelper.transitionToPage(context, const ProfileScreen())
          : {};
      return;
    }
    mounted
        ? PlatformHelper.transitionToPage(context, const LoginScreen())
        : {};
  }

  ///Action called when pressing hte favorite icon button on movie card
  Future<void> onAddFavoriteMovie(int? id) async {
    if (await _checkLogin() == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "You need to login before adding to favorites")
          : {};
      return;
    }
    mounted
        ? PlatformHelper.showLoadingAlert(context, 'Adding movie to favorites')
        : {};

    HandlingServerLog result = await _movieService.addToFavorites(id!, true);

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    // If failed showing error message
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
          ? PlatformHelper.showSuccessSnackbar(
              context, "Movie is added to favorites")
          : {};
      return;
    }

    return;
  }

  Future<void> onAddWatchList(int? id) async {
    if (await _checkLogin() == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "You need to login before adding to your watch list")
          : {};
      return;
    }
    mounted
        ? PlatformHelper.showLoadingAlert(context, 'Adding movie to watch list')
        : {};

    HandlingServerLog result = await _movieService.onAddToWatchList(id!, true);

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    if (result.success == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Failed to add movie to your watch list")
          : {};
      return;
    }

    // If status success but movie is already in the watch list
    if (result.success == true && result.status == 12) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Movie is already in your watch list")
          : {};
      return;
    }

    if (result.success == true && result.status == 1) {
      mounted
          ? PlatformHelper.showSuccessSnackbar(
              context, "Movie is added to your watch list")
          : {};
      return;
    }

    return;
  }

  /// Function called to check the user's session
  Future<bool> _checkLogin() async {
    /// Fetching the session id stored inside the secure storage
    var sessionID = await SecureStorageHelper.getSession();

    /// Fetching the user id stored inside the secure storage
    var userID = await SecureStorageHelper.getUserID();

    if (userID == null || sessionID == null) {
      return false;
    }
    return true;
  }

  /// Action called when download button clicked asking
  Future<void> onDownloadImage(String url) async {

    /// permission will only be asked for android below the version of 29
    var permission = await FlDownloader.requestPermission();

    if (permission == StoragePermissionStatus.granted) {
      await FlDownloader.download(url);
    }
  }
}
