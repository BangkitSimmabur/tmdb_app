import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:tmdb_app/helpers/server_helper.dart';
import 'package:tmdb_app/models/movie.dart';
import 'package:tmdb_app/services/constant_service.dart';
import 'package:tmdb_app/services/network_service.dart';

class MovieService extends NetworkService {
  List<Movie>? nowPlaying = [];

  MovieService(super.constantService);

  Future<List<Movie>?> getNowPlaying() async {
    HandlingServerLog serverLog = await doHttpGet(
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1&api_key=5768f327d0eee19143087d1e23116d27');

    if (serverLog.data['results'] != null) {
      var movies = moviesFromJson(serverLog.data['results']);
      print(movies);
      return movies;
    }
    return null;
  }

  Future<Movie?> getMovieDetail(int id) async {
    HandlingServerLog serverLog = await doHttpGet(
        'https://api.themoviedb.org/3/movie/$id?language=en-US&api_key=5768f327d0eee19143087d1e23116d27');

    if (serverLog.data != null) {
      Movie? movieDetail = Movie.fromJson(serverLog.data);
      return movieDetail;
    }
    return null;
  }
}
