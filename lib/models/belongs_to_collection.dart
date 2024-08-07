import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'belongs_to_collection.g.dart';

@JsonSerializable(explicitToJson: true)
class BelongsToCollection {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  BelongsToCollection(
      this.id,
      this.name,
      this.posterPath,
      this.backdropPath,
      );

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

BelongsToCollection? belongsToCollectionFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return _$BelongsToCollectionFromJson(decoded);
}

List<BelongsToCollection>? belongsToCollectionsFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return decoded.map<BelongsToCollection>((dynamic json) => _$BelongsToCollectionFromJson(json)).toList();
}
