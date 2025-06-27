// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TokenInfo _$TokenInfoFromJson(Map<String, dynamic> json) => _TokenInfo(
  value: json['value'] as String,
  expiredAt: (json['expiredAt'] as num).toInt(),
);

Map<String, dynamic> _$TokenInfoToJson(_TokenInfo instance) =>
    <String, dynamic>{'value': instance.value, 'expiredAt': instance.expiredAt};
