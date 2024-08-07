import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'production_company.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductionCompany {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'logo_path')
  String? logoPath;
  @JsonKey(name: 'origin_country')
  String? originCountry;

  ProductionCompany(
    this.id,
    this.name,
    this.logoPath,
    this.originCountry,
  );

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

ProductionCompany? productionCompanyFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return _$ProductionCompanyFromJson(decoded);
}

List<ProductionCompany>? productionCompaniesFromJson(dynamic map) {
  if (map == null) return null;

  dynamic decoded;
  if (map is String) {
    decoded = json.decode(map);
  } else {
    decoded = map;
  }

  return decoded
      .map<ProductionCompany>(
          (dynamic json) => _$ProductionCompanyFromJson(json))
      .toList();
}
