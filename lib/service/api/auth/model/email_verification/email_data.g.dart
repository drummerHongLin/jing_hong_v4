// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmailVerifingRequest _$EmailVerifingRequestFromJson(
  Map<String, dynamic> json,
) => _EmailVerifingRequest(code: json['code'] as String);

Map<String, dynamic> _$EmailVerifingRequestToJson(
  _EmailVerifingRequest instance,
) => <String, dynamic>{'code': instance.code};

_EmailVerifiedResponse _$EmailVerifiedResponseFromJson(
  Map<String, dynamic> json,
) => _EmailVerifiedResponse(
  token: json['token'] as String,
  expiredAt: (json['expiredAt'] as num).toInt(),
);

Map<String, dynamic> _$EmailVerifiedResponseToJson(
  _EmailVerifiedResponse instance,
) => <String, dynamic>{
  'token': instance.token,
  'expiredAt': instance.expiredAt,
};
