// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      (json['id'] as num?)?.toInt(),
      json['title'] as String?,
      json['adult'] as bool?,
      json['backdrop_path'] as String?,
      (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      json['original_title'] as String?,
      json['overview'] as String?,
      (json['popularity'] as num?)?.toDouble(),
      json['poster_path'] as String?,
      json['release_date'] as String?,
      json['video'] as bool?,
      (json['vote_average'] as num?)?.toDouble(),
      (json['vote_count'] as num?)?.toInt(),
      (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      belongsToCollectionFromJson(json['belongs_to_collection']),
      (json['Budget'] as num?)?.toDouble(),
      genresFromJson(json['genres']),
      json['homepage'] as String?,
      json['imdb_id'] as String?,
      json['original_language'] as String?,
      productionCompaniesFromJson(json['production_companies']),
      productionCountriesFromJson(json['production_countries']),
      (json['revenue'] as num?)?.toDouble(),
      (json['runtime'] as num?)?.toInt(),
      spokenLanguagesFromJson(json['spoken_languages']),
      json['status'] as String?,
      json['tagline'] as String?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'adult': instance.adult,
      'genre_ids': instance.genreIds,
      'backdrop_path': instance.backdropPath,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genres': instance.genres?.map((e) => e.toJson()).toList(),
      'belongs_to_collection': instance.belongsToCollection?.toJson(),
      'origin_country': instance.originCountry,
      'homepage': instance.homepage,
      'Budget': instance.budget,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
      'production_companies':
          instance.productionCompanies?.map((e) => e.toJson()).toList(),
      'production_countries':
          instance.productionCountries?.map((e) => e.toJson()).toList(),
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spoken_languages':
          instance.spokenLanguages?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'tagline': instance.tagline,
    };
