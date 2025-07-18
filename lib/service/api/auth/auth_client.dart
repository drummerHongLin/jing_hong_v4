import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jing_hong_v4/service/api/auth/model/email_verification/email_data.dart';
import 'package:jing_hong_v4/service/api/auth/model/login/login_data.dart';

class AuthClient {
  final Dio client;

  AuthClient({String? baseUrl})
    : client = Dio(BaseOptions(baseUrl: baseUrl ?? "https://www.honghouse.cn/api/"));

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

  Future<bool> verifyUser(String username) async {
    final rst = await client.get("/v1/users/$username/verify");
    if (rst.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<void> changePassword(
    ChangePasswordRequest request,
    String username,
    String token,
  ) async {
    await client.put(
      "/v1/users/$username/change-password",
      data: jsonEncode(request),
      options: Options(headers: {'Authorization': 'Bearer $token'}),
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

  Future<void> setAvatar(String username, String token, XFile file) async {
    final f = await file.readAsBytes();
    final formData = FormData.fromMap({
      'file':  MultipartFile.fromBytes(f,filename: file.name),
    });

    await client.post(
      "/v1/users/$username/set-avatar",
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}
