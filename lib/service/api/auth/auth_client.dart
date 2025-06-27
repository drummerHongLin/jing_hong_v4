import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jing_hong_v4/service/api/auth/model/email_verification/email_data.dart';
import 'package:jing_hong_v4/service/api/auth/model/login/login_data.dart';

class AuthClient {
  final Dio client;

  AuthClient({String? baseUrl})
    : client = Dio(BaseOptions(baseUrl: baseUrl ?? "http://localhost:8080"));

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await client.post(
      "/login",
      data: jsonEncode(loginRequest),
    );
    return LoginResponse.fromJson(response.data);
  }

  Future<void> register(RegisterRequest request) async {
    await client.post("/v1/users/register", data: jsonEncode(request));
  }

  Future<GetUserResponse> getUser(String token) async {
    final res = await client.get(
      "/v1/users/current-user",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return GetUserResponse.fromJson(res.data);
  }

  Future<void> changePassword(
    ChangePasswordRequest request,
    String username,
  ) async {
    await client.post(
      "/v1/users/$username/change-password",
      data: jsonEncode(request),
    );
  }

  Future<void> sendEmail(String username) async {
    await client.get("/v1/users/$username/send-email");
  }

  Future<EmailVerifiedResponse> verifyEmail(
    String username,
    EmailVerifingRequest request,
  ) async {
    final res = await client.post(
      "/v1/users/$username/verify-email",
      data: jsonEncode(request),
    );
    return EmailVerifiedResponse.fromJson(res.data);
  }
}
