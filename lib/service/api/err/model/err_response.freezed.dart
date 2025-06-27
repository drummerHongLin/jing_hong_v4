// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'err_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ErrResponse {

 String get role; String get content;
/// Create a copy of ErrResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ErrResponseCopyWith<ErrResponse> get copyWith => _$ErrResponseCopyWithImpl<ErrResponse>(this as ErrResponse, _$identity);

  /// Serializes this ErrResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ErrResponse&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'ErrResponse(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $ErrResponseCopyWith<$Res>  {
  factory $ErrResponseCopyWith(ErrResponse value, $Res Function(ErrResponse) _then) = _$ErrResponseCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$ErrResponseCopyWithImpl<$Res>
    implements $ErrResponseCopyWith<$Res> {
  _$ErrResponseCopyWithImpl(this._self, this._then);

  final ErrResponse _self;
  final $Res Function(ErrResponse) _then;

/// Create a copy of ErrResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ErrResponse implements ErrResponse {
  const _ErrResponse({required this.role, required this.content});
  factory _ErrResponse.fromJson(Map<String, dynamic> json) => _$ErrResponseFromJson(json);

@override final  String role;
@override final  String content;

/// Create a copy of ErrResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrResponseCopyWith<_ErrResponse> get copyWith => __$ErrResponseCopyWithImpl<_ErrResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ErrResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ErrResponse&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'ErrResponse(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ErrResponseCopyWith<$Res> implements $ErrResponseCopyWith<$Res> {
  factory _$ErrResponseCopyWith(_ErrResponse value, $Res Function(_ErrResponse) _then) = __$ErrResponseCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$ErrResponseCopyWithImpl<$Res>
    implements _$ErrResponseCopyWith<$Res> {
  __$ErrResponseCopyWithImpl(this._self, this._then);

  final _ErrResponse _self;
  final $Res Function(_ErrResponse) _then;

/// Create a copy of ErrResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_ErrResponse(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
