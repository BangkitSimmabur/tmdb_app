import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'production_country.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  String? code;
  @JsonKey(name: 'name')
  String? name;

  ProductionCountry(
      this.code,
      this.name,
      );

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}

ProductionCountry? productionCountryFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return _$ProductionCountryFromJson(decoded);
}

List<ProductionCountry>? productionCountriesFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return decoded
      .map<ProductionCountry>(
          (dynamic json) => _$ProductionCountryFromJson(json))
      .toList();
}
