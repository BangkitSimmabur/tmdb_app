import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/reusable_components/common_components/button_full.dart';
import 'package:tmdb_app/reusable_components/common_components/common_app_bar.dart';
import 'package:tmdb_app/reusable_components/common_components/common_text.dart';
import 'package:tmdb_app/screens/home/home_screen.dart';
import 'package:tmdb_app/screens/profile/profile_movies_component.dart';
import 'package:tmdb_app/services/auth_service.dart';
import 'package:tmdb_app/services/movie_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late MovieService _movieService;
  late AuthService _authService;
  final favoriteScrollController = ScrollController();
  final watchListScrollController = ScrollController();
  bool favoriteLoading = true;
  bool watchListLoading = true;
  List<Movie> favoriteMovies = [];
  List<Movie> watchListMovies = [];
  int favoritePage = 1;
  int watchListPage = 1;
  bool canFetchFavorite = true;
  bool canFetchWatchlist = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, initDataState);

    // event listener when scrolling to the of list
    favoriteScrollController.addListener(() {
      if (favoriteScrollController.position.maxScrollExtent ==
          favoriteScrollController.offset) {
        fetchFavoriteMovie();
      }
    });
    watchListScrollController.addListener(() {
      if (watchListScrollController.position.maxScrollExtent ==
          watchListScrollController.offset) {
        fetchWatchList();
      }
    });
  }

  @override
  void dispose() {
    favoriteScrollController.dispose();
    watchListScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _movieService = Provider.of<MovieService>(context);
    _authService = Provider.of<AuthService>(context);

    return Scaffold(
      backgroundColor: Constant.colorBlack,
      appBar: const CommonAppBar(
        "Profile",
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: Constant.paddingMD),
                    child: CommonText(
                      "Favorite Movies",
                      textColor: Constant.colorWhite,
                      fontSize: Constant.fontSizeLG,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ProfileMovieComponent(
                    isLoading: favoriteLoading,
                    scrollController: favoriteScrollController,
                    movies: favoriteMovies,
                    onRemoveFromList: onRemoveFavoriteMovie,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Constant.fontSizeMD),
                    child: Divider(
                      color: Constant.colorDarkRed,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: Constant.paddingMD),
                    child: CommonText(
                      "Watch List",
                      textColor: Constant.colorWhite,
                      fontSize: Constant.fontSizeLG,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ProfileMovieComponent(
                    isLoading: watchListLoading,
                    scrollController: watchListScrollController,
                    movies: watchListMovies,
                    onRemoveFromList: onRemoveWatchList,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: CustomButtonFullBordered(
              'Log out',
              labelColor: Colors.black,
              labelSize: 16,
              labelWeight: FontWeight.w600,
              buttonColor: Constant.colorWhite,
              borderRadius: 4,
              onClick: logOut,
            ),
          ),
        ],
      ),
    );
  }

  /// Action ran when the page first load fetching movies from watch list and favorite list
  Future initDataState() async {
    fetchFavoriteMovie();
    fetchWatchList();
  }

  Future<void> fetchFavoriteMovie() async {
    if (!canFetchFavorite) {
      return;
    }

    favoriteLoading == false
        ? setState(() {
            favoriteLoading = true;
          })
        : {};
    var serverLog = await _movieService.getFavoriteMovies(favoritePage);

    if (serverLog.data["results"] != null) {
      var movies = moviesFromJson(serverLog.data['results']);
      setState(() {
        favoriteMovies = [...favoriteMovies, ...movies ?? []];
        favoritePage = favoritePage + 1;
      });

      // If the last page reached
      if (favoritePage > serverLog.data["total_pages"]!) {
        setState(() {
          canFetchFavorite = false;
        });
      }
    }

    setState(() {
      favoriteLoading = false;
    });
    return;
  }

  Future<void> fetchWatchList() async {
    if (!canFetchWatchlist) {
      return;
    }

    watchListLoading == false
        ? setState(() {
            watchListLoading = true;
          })
        : {};
    var serverLog = await _movieService.getWatchList(watchListPage);

    if (serverLog.data["results"] != null) {
      var movies = moviesFromJson(serverLog.data['results']);
      setState(() {
        watchListMovies = [...watchListMovies, ...movies ?? []];
        watchListPage = watchListPage + 1;
      });

      // If the last page reached
      if (watchListPage > serverLog.data["total_pages"]) {
        setState(() {
          canFetchWatchlist = false;
        });
      }
    }

    setState(() {
      watchListLoading = false;
    });
    return;
  }

  /// Action called when the trash icon button pressed on favorite movies
  Future<void> onRemoveFavoriteMovie(int? id) async {
    PlatformHelper.showLoadingAlert(context, 'Removing movie from favorites');

    HandlingServerLog result = await _movieService.addToFavorites(id!, false);

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    if (result.success == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Failed to remove movie from favorites")
          : {};
      return;
    }

    if (result.success == true) {
      mounted
          ? PlatformHelper.showSuccessSnackbar(
              context, "Movie removed from favorites")
          : {};
      setState(() {
        favoriteMovies.removeWhere((e) => e.id == id);
      });
      return;
    }

    return;
  }

  /// Action called when the trash icon button pressed on watch list
  Future<void> onRemoveWatchList(int? id) async {
    PlatformHelper.showLoadingAlert(context, 'Removing movie from watch list');

    HandlingServerLog result = await _movieService.onAddToWatchList(id!, false);

    mounted ? PlatformHelper.backTransitionPage(context) : {};

    if (result.success == false) {
      mounted
          ? PlatformHelper.showErrorSnackbar(
              context, "Failed to remove movie from your watch list")
          : {};
      return;
    }

    if (result.success == true) {
      mounted
          ? PlatformHelper.showSuccessSnackbar(
              context, "Movie removed from your watch list")
          : {};

      setState(() {
        watchListMovies.removeWhere((e) => e.id == id);
      });
      return;
    }

    return;
  }

  /// Action called when Log out button pressed, deleting session from tmdb and remove it from device
  Future<void> logOut() async {
    await _authService.removeSession();

    mounted
        ? PlatformHelper.transitionToPage(context, const HomeScreen(), newPage: true)
        : {};
  }
}
