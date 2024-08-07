import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'spoken_language.g.dart';

@JsonSerializable(explicitToJson: true)
class SpokenLanguage {
  @JsonKey(name: 'english_name')
  String? id;
  @JsonKey(name: 'iso_639_1')
  String? code;
  @JsonKey(name: 'name')
  String? name;

  SpokenLanguage(
      this.id,
      this.code,
      this.name,
      );

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}

SpokenLanguage? spokenLanguageFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return _$SpokenLanguageFromJson(decoded);
}

List<SpokenLanguage>? spokenLanguagesFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return decoded.map<SpokenLanguage>((dynamic json) => _$SpokenLanguageFromJson(json)).toList();
}
