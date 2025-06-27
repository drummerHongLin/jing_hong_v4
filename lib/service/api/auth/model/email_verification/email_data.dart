import 'package:freezed_annotation/freezed_annotation.dart' ;

part 'email_data.freezed.dart';
part 'email_data.g.dart';

@freezed
abstract  class EmailVerifingRequest with _$EmailVerifingRequest {
  const factory EmailVerifingRequest({
    required String code,
  }) = _EmailVerifingRequest;

  factory EmailVerifingRequest.fromJson(Map<String, dynamic> json) =>
      _$EmailVerifingRequestFromJson(json);
}


@freezed
abstract  class EmailVerifiedResponse with _$EmailVerifiedResponse {
  const factory EmailVerifiedResponse({
    required String token,
    required int expiredAt
  }) = _EmailVerifiedResponse;

  factory EmailVerifiedResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailVerifiedResponseFromJson(json);
}
