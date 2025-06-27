

import 'package:freezed_annotation/freezed_annotation.dart' ;

part 'login_data.freezed.dart';
part 'login_data.g.dart';

@freezed
abstract  class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String username,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}


@freezed
abstract  class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String token,
    required int expiredAt
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
abstract  class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String username,
    required String password,
    required String nickname,
    required String email
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}



@freezed
abstract  class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

@freezed
abstract  class GetUserResponse with _$GetUserResponse {
  const factory GetUserResponse({
    required int id,
    required String username,
    required String password,
    required String nickname,
    required String email,
    required String avatarUrl,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt, 

  }) = _GetUserResponse;

  factory GetUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseFromJson(json);
}


