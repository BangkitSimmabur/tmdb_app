import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/helpers/date_helper.dart';
import 'package:tmdb_app/models/belongs_to_collection.dart';
import 'package:tmdb_app/models/genre.dart';
import 'package:tmdb_app/models/production_company.dart';
import 'package:tmdb_app/models/production_country.dart';
import 'package:tmdb_app/models/spoken_language.dart';

part 'movie.g.dart';

@JsonSerializable(explicitToJson: true)
class Movie {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'adult')
  bool? adult;
  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  @JsonKey(name: 'original_title')
  String? originalTitle;
  @JsonKey(name: 'overview')
  String? overview;
  @JsonKey(name: 'popularity')
  double? popularity;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(
    name: 'release_date',
    fromJson: DateHelper.convertDateAndIsoString,
    toJson: DateHelper.convertDateAndIsoString,
  )
  DateTime? releaseDate;
  @JsonKey(name: 'video')
  bool? video;
  @JsonKey(name: 'vote_average')
  double? voteAverage;
  @JsonKey(name: 'vote_count')
  int? voteCount;
  @JsonKey(name: 'genres', fromJson: genresFromJson)
  List<Genre>? genres;
  @JsonKey(name: 'belongs_to_collection', fromJson: belongsToCollectionFromJson)
  BelongsToCollection? belongsToCollection;
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;
  @JsonKey(name: 'homepage')
  String? homepage;
  @JsonKey(name: 'Budget')
  double? budget;
  @JsonKey(name: 'imdb_id')
  String? imdbId;
  @JsonKey(name: 'original_language')
  String? originalLanguage;
  @JsonKey(name: 'production_companies', fromJson: productionCompaniesFromJson)
  List<ProductionCompany>? productionCompanies;
  @JsonKey(name: 'production_countries', fromJson: productionCountriesFromJson)
  List<ProductionCountry>? productionCountries;
  @JsonKey(name: 'revenue')
  double? revenue;
  @JsonKey(name: 'runtime')
  int? runtime;
  @JsonKey(name: 'spoken_languages', fromJson: spokenLanguagesFromJson)
  List<SpokenLanguage>? spokenLanguages;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'tagline')
  String? tagline;

  Movie(
    this.id,
    this.title,
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.imdbId,
    this.originalLanguage,
    this.productionCompanies,
    this.productionCountries,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
  );

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

Movie? movieFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return _$MovieFromJson(decoded);
}

List<Movie>? moviesFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return decoded.map<Movie>((dynamic json) => _$MovieFromJson(json)).toList();
}
