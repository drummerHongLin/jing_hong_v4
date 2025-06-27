import 'package:freezed_annotation/freezed_annotation.dart' ;

part 'err_response.freezed.dart';
part 'err_response.g.dart';

@freezed
abstract  class ErrResponse with _$ErrResponse {
  const factory ErrResponse({
    required String role,
    required String content,
  }) = _ErrResponse;

  factory ErrResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrResponseFromJson(json);
}