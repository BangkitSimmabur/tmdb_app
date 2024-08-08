import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/components/common_components/common_spinner.dart';
import 'package:tmdb_app/components/common_components/common_text.dart';
import 'package:tmdb_app/components/common_components/outline_button.dart';
import 'package:tmdb_app/components/movie_card.dart';
import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/platform_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/services/movie_service.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({
    super.key,
    required this.movieId,
  });
  final int movieId;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  late MovieService _movieService;
  bool movieDetailLoading = true;
  bool similarMovieLoading = true;
  Movie? movieDetail;
  List<Movie>? similarMovies = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, initDataState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _movieService = Provider.of<MovieService>(context);
    return Scaffold(
      backgroundColor: Constant.black,
      body: movieDetailLoading
          ? const CommonSpinner()
          : CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  backgroundColor: Constant.black,
                  leading: Container(
                    height: 70,
                    width: 70,
                    margin: const EdgeInsets.only(
                      top: Constant.paddingMD,
                      left: Constant.paddingMD,
                    ),
                    decoration: BoxDecoration(
                      color: Constant.blackOpacity75,
                      borderRadius: BorderRadius.circular(
                        Constant.borderRadiusSM,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        PlatformHelper.backTransitionPage(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Constant.white,
                      ),
                    ),
                  ),
                  expandedHeight: MediaQuery.sizeOf(context).height *2/5,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.all(0),
                    centerTitle: true,
                    title: ClipRRect(
                      borderRadius: BorderRadius.circular(Constant.borderRadiusSM),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: Constant.paddingXS,
                            horizontal: Constant.paddingXXS),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Constant.blackOpacity25,
                              Constant.blackOpacity50,
                              Constant.blackOpacity75,
                              Constant.black,
                            ],
                          ),
                        ),
                        child: CommonText(
                          movieDetail?.title != null
                              ? "${movieDetail?.title} (${movieDetail?.releaseDate?.year})"
                              : "",
                          textColor: Constant.white,
                          fontSize: Constant.fontSizeMD,
                        ),
                      ),
                    ),
                    // title: CommonText(movieDetail?.title ?? ""),
                    background: Image.network(
                      "${Constant.imagePathOriginal}/${movieDetail?.backdropPath}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(Constant.paddingSM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: Constant.spacingXS),
                          child: Center(
                            child: RatingStars(
                              maxValue: 10,
                              value: movieDetail?.voteAverage ?? 0,
                              starCount: 5,
                              starSpacing: 4,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Constant.paddingXXS),
                                child: CustomOutlinedButton(
                                  "+ Watchlist",
                                  onTap: () {},
                                  buttonColor: Constant.black,
                                  borderColor: Constant.white,
                                  labelColor: Constant.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Constant.paddingXXS),
                                child: CustomOutlinedButton(
                                  "+ Favorite",
                                  onTap: () {},
                                  buttonColor: Constant.black,
                                  borderColor: Constant.white,
                                  labelColor: Constant.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Constant.paddingSM),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CommonText(
                                "Genre: ",
                                fontWeight: FontWeight.bold,
                                textColor: Constant.white,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: Constant.spacingXS),
                                  child: CommonText(
                                    getGenres() + getGenres(),
                                    fontSize: Constant.fontSizeXS,
                                    textColor: Constant.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Constant.whiteOpacity75,
                            child: Padding(
                              padding: const EdgeInsets.all(Constant.paddingSM),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CommonText(
                                    "Overview",
                                    fontWeight: FontWeight.bold,
                                    fontSize: Constant.fontSizeMD,
                                  ),
                                  const Divider(
                                    color: Constant.black,
                                  ),
                                  CommonText(
                                    movieDetail?.overview ?? "",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: Constant.spacingMD),
                          child: CommonText(
                            "More like this",
                            fontWeight: FontWeight.bold,
                            fontSize: Constant.fontSizeMD,
                            textColor: Constant.white,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const Divider(
                          color: Constant.white,
                        ),
                        similarMovieLoading
                            ? const CommonSpinner()
                            : Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children: listSimilarMovies,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future initDataState() async {
    var fetchMovieDetail = await _movieService.getMovieDetail(widget.movieId);
    setState(() {
      movieDetailLoading = false;
      movieDetail = fetchMovieDetail;
    });

    var fetchSimilarMovies = await _movieService.getMovieByGenres(getGenreIds());
    setState(() {
      similarMovieLoading = false;
      similarMovies = fetchSimilarMovies;
    });
  }

  String getGenres() {
    var genres = movieDetail!.genres!.map((e) => e.name).toList();
    if (genres.isNotEmpty) {
      return genres.join(', ');
    }
    return "";
  }
  List<int?> getGenreIds() {
    if (movieDetail!.genres!.isNotEmpty) {
      return movieDetail!.genres!.map((e) => e.id).toList();
    }
    return [];
  }

  List<Widget> get listSimilarMovies {
    List<Widget> listWidgets = [];
    similarMovies?.asMap().forEach((int key, Movie movie) {
      listWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Constant.paddingMD),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height* 0.3,
            child: MovieCard(
              movie: movie,
            ),
          ),
        ),
      );
    });

    return listWidgets;
  }
}