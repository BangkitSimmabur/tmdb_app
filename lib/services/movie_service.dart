import 'package:tmdb_app/helpers/constant.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/services/network_service.dart';

class MovieService extends NetworkService {
  MovieService(super.constantService);

  Future<List<Movie>?> getNowPlaying() async {
    HandlingServerLog serverLog = await doHttpGet(
        '/movie/now_playing?language=en-US&page=1&api_key=${Constant.tmdbApiKey}');

    if (serverLog.data['results'] != null) {
      var movies = moviesFromJson(serverLog.data['results']);
      return movies;
    }
    return [];
  }

  Future<Movie?> getMovieDetail(int id) async {
    HandlingServerLog serverLog = await doHttpGet(
        '/movie/$id?language=en-US&api_key=${Constant.tmdbApiKey}');

    if (serverLog.data != null) {
      Movie? movieDetail = Movie.fromJson(serverLog.data);
      return movieDetail;
    }
    return null;
  }

  Future<List<Movie>?> getPopularMovies() async {
    HandlingServerLog serverLog = await doHttpGet(
        '/movie/popular?language=en-US&page=1&api_key=${Constant.tmdbApiKey}');

    if (serverLog.data['results'] != null) {
      var movies = moviesFromJson(serverLog.data['results']);
      return movies;
    }
    return null;
  }

  Future<List<Movie>?> getMovieByGenres(List<int?> genres) async {
    String listGenre = genres.join(' | ');
    HandlingServerLog serverLog = await doHttpGet(
        "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=$listGenre&api_key=${Constant.tmdbApiKey}");

    if (serverLog.data['results'] != null) {
      var movies = moviesFromJson(serverLog.data['results']);
      return movies;
    }
    return null;
  }

  Future<HandlingServerLog> addToFavorites(int id, bool isAdd) async {
    Map<String, dynamic> sessionReqBody = {
      "media_type": "movie",
      "media_id": id,
      "favorite": isAdd,
    };

    HandlingServerLog serverLog = await doHttpPost(
        '/account/${constantService.sessionID}/favorite?session_id=${constantService.sessionID}&api_key=${Constant.tmdbApiKey}',
        sessionReqBody);

    return serverLog;
  }

  Future<HandlingServerLog> onAddToWatchList(int id, bool isAdd) async {
    Map<String, dynamic> sessionReqBody = {
      "media_type": "movie",
      "media_id": id,
      "watchlist": isAdd,
    };

    HandlingServerLog serverLog = await doHttpPost(
        '/account/${constantService.sessionID}/watchlist?session_id=${constantService.sessionID}&api_key=${Constant.tmdbApiKey}',
        sessionReqBody);

    return serverLog;
  }
  // account/8314267/favorite/movies?language=en-US&page=1&session_id=546114646e850200cc707538f2465478400eb45e&sort_by=created_at.asc

  Future<HandlingServerLog> getFavoriteMovies(int page) async {
    HandlingServerLog serverLog = await doHttpGet(
        '/account/${constantService.userID}/favorite/movies?language=en-US&page=$page&session_id=${constantService.sessionID}&sort_by=created_at.asc&api_key=${Constant.tmdbApiKey}');

    return serverLog;
  }
}
