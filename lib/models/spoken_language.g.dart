// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoken_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      json['english_name'] as String?,
      json['iso_639_1'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      'english_name': instance.id,
      'iso_639_1': instance.code,
      'name': instance.name,
    };
