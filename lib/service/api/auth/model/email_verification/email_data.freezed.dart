// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmailVerifingRequest {

 String get code;
/// Create a copy of EmailVerifingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerifingRequestCopyWith<EmailVerifingRequest> get copyWith => _$EmailVerifingRequestCopyWithImpl<EmailVerifingRequest>(this as EmailVerifingRequest, _$identity);

  /// Serializes this EmailVerifingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerifingRequest&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'EmailVerifingRequest(code: $code)';
}


}

/// @nodoc
abstract mixin class $EmailVerifingRequestCopyWith<$Res>  {
  factory $EmailVerifingRequestCopyWith(EmailVerifingRequest value, $Res Function(EmailVerifingRequest) _then) = _$EmailVerifingRequestCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$EmailVerifingRequestCopyWithImpl<$Res>
    implements $EmailVerifingRequestCopyWith<$Res> {
  _$EmailVerifingRequestCopyWithImpl(this._self, this._then);

  final EmailVerifingRequest _self;
  final $Res Function(EmailVerifingRequest) _then;

/// Create a copy of EmailVerifingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EmailVerifingRequest implements EmailVerifingRequest {
  const _EmailVerifingRequest({required this.code});
  factory _EmailVerifingRequest.fromJson(Map<String, dynamic> json) => _$EmailVerifingRequestFromJson(json);

@override final  String code;

/// Create a copy of EmailVerifingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailVerifingRequestCopyWith<_EmailVerifingRequest> get copyWith => __$EmailVerifingRequestCopyWithImpl<_EmailVerifingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailVerifingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailVerifingRequest&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'EmailVerifingRequest(code: $code)';
}


}

/// @nodoc
abstract mixin class _$EmailVerifingRequestCopyWith<$Res> implements $EmailVerifingRequestCopyWith<$Res> {
  factory _$EmailVerifingRequestCopyWith(_EmailVerifingRequest value, $Res Function(_EmailVerifingRequest) _then) = __$EmailVerifingRequestCopyWithImpl;
@override @useResult
$Res call({
 String code
});




}
/// @nodoc
class __$EmailVerifingRequestCopyWithImpl<$Res>
    implements _$EmailVerifingRequestCopyWith<$Res> {
  __$EmailVerifingRequestCopyWithImpl(this._self, this._then);

  final _EmailVerifingRequest _self;
  final $Res Function(_EmailVerifingRequest) _then;

/// Create a copy of EmailVerifingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_EmailVerifingRequest(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EmailVerifiedResponse {

 String get token; int get expiredAt;
/// Create a copy of EmailVerifiedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerifiedResponseCopyWith<EmailVerifiedResponse> get copyWith => _$EmailVerifiedResponseCopyWithImpl<EmailVerifiedResponse>(this as EmailVerifiedResponse, _$identity);

  /// Serializes this EmailVerifiedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerifiedResponse&&(identical(other.token, token) || other.token == token)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,expiredAt);

@override
String toString() {
  return 'EmailVerifiedResponse(token: $token, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class $EmailVerifiedResponseCopyWith<$Res>  {
  factory $EmailVerifiedResponseCopyWith(EmailVerifiedResponse value, $Res Function(EmailVerifiedResponse) _then) = _$EmailVerifiedResponseCopyWithImpl;
@useResult
$Res call({
 String token, int expiredAt
});




}
/// @nodoc
class _$EmailVerifiedResponseCopyWithImpl<$Res>
    implements $EmailVerifiedResponseCopyWith<$Res> {
  _$EmailVerifiedResponseCopyWithImpl(this._self, this._then);

  final EmailVerifiedResponse _self;
  final $Res Function(EmailVerifiedResponse) _then;

/// Create a copy of EmailVerifiedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = null,Object? expiredAt = null,}) {
  return _then(_self.copyWith(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,expiredAt: null == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _EmailVerifiedResponse implements EmailVerifiedResponse {
  const _EmailVerifiedResponse({required this.token, required this.expiredAt});
  factory _EmailVerifiedResponse.fromJson(Map<String, dynamic> json) => _$EmailVerifiedResponseFromJson(json);

@override final  String token;
@override final  int expiredAt;

/// Create a copy of EmailVerifiedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailVerifiedResponseCopyWith<_EmailVerifiedResponse> get copyWith => __$EmailVerifiedResponseCopyWithImpl<_EmailVerifiedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailVerifiedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailVerifiedResponse&&(identical(other.token, token) || other.token == token)&&(identical(other.expiredAt, expiredAt) || other.expiredAt == expiredAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,token,expiredAt);

@override
String toString() {
  return 'EmailVerifiedResponse(token: $token, expiredAt: $expiredAt)';
}


}

/// @nodoc
abstract mixin class _$EmailVerifiedResponseCopyWith<$Res> implements $EmailVerifiedResponseCopyWith<$Res> {
  factory _$EmailVerifiedResponseCopyWith(_EmailVerifiedResponse value, $Res Function(_EmailVerifiedResponse) _then) = __$EmailVerifiedResponseCopyWithImpl;
@override @useResult
$Res call({
 String token, int expiredAt
});




}
/// @nodoc
class __$EmailVerifiedResponseCopyWithImpl<$Res>
    implements _$EmailVerifiedResponseCopyWith<$Res> {
  __$EmailVerifiedResponseCopyWithImpl(this._self, this._then);

  final _EmailVerifiedResponse _self;
  final $Res Function(_EmailVerifiedResponse) _then;

/// Create a copy of EmailVerifiedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? expiredAt = null,}) {
  return _then(_EmailVerifiedResponse(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,expiredAt: null == expiredAt ? _self.expiredAt : expiredAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
