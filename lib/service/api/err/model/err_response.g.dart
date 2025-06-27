// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'err_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrResponse _$ErrResponseFromJson(Map<String, dynamic> json) => _ErrResponse(
  role: json['role'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$ErrResponseToJson(_ErrResponse instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};
