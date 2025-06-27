import 'package:dio/dio.dart';
import 'package:jing_hong_v4/data/data/auth/auth_repo.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/service/api/auth/auth_client.dart';
import 'package:jing_hong_v4/service/api/auth/model/email_verification/email_data.dart';
import 'package:jing_hong_v4/service/api/auth/model/login/login_data.dart';
import 'package:jing_hong_v4/service/preference/model/token_info.dart';
import 'package:jing_hong_v4/service/preference/shared_preferences_servicec.dart';
import 'package:jing_hong_v4/utils/result.dart';

class AuthRepoRemote extends AuthRepo {
  final SharedPreferencesService _preferencesService;
  final AuthClient _authClient;
  TokenInfo? _token;
  set token(TokenInfo? t) {
    _token = t;
  }

  @override
  TokenInfo? get token {
    if( _token == null) return null;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_token!.expiredAt < now) {
        logout();
        return null;
    }
    return _token;
  }

  AuthRepoRemote({
    required SharedPreferencesService preferencesService,
    required AuthClient authClient,
  }) : _preferencesService = preferencesService,
       _authClient = authClient;

  @override
  Future<Result<void>> changePassword(String newPassword) async {
    return Success(null);
  }

  

  @override
  Future<Result<void>> login(String username, String password) async {
    try {
      final rst1 = await _authClient.login(
        LoginRequest(username: username, password: password),
      );
      token = TokenInfo(value: rst1.token, expiredAt: rst1.expiredAt);
      _preferencesService.saveToken(_token);
      return Success(null);
    } 
        on DioException catch(e){
      if(e.response?.data != null){
        final data = e.response?.data;
         return Failure("登录失败:${data['message']}", e);
      }
      return Failure("登录失败!", e);
    }
    
    on Exception catch (e) {
      return Failure("登录失败!", e);
    }
  }

  @override
  Future<Result<void>> register(String username, String code) async {
    try {
      final rst1 = await _authClient.verifyEmail(
        username,
        EmailVerifingRequest(code: code),
      );
      token = TokenInfo(value: rst1.token, expiredAt: rst1.expiredAt);
      _preferencesService.saveToken(_token);
      return Success(null);
    } 
    on DioException catch(e){
      if(e.response?.data != null){
        final data = e.response?.data;
         return Failure("注册失败:${data['message']}", e);
      }
      return Failure("注册失败!", e);
    }
    on Exception catch (e) {
      return Failure("注册失败!", e);
    }
  }

  @override
  Future<Result<void>> sendVerificationEmail(
    String username,
    String password,
    String nickname,
    String email,
  ) async {
    try {
      // 先注册用户信息
      await _authClient.register(
        RegisterRequest(
          username: username,
          password: password,
          nickname: nickname,
          email: email,
        ),
      );
      // 注册成功后，发送邮件
      await _authClient.sendEmail(username);
      return Success(null);
    } on DioException catch (e) {
      return Failure("网络错误：", e);
    } on Exception catch (e) {
      return Failure("服务错误：", e);
    }
  }

  Future<Result<void>> _fetchToken() async {
    final tokenInfo = await _preferencesService.fetchToken();
    if (tokenInfo == null) return Failure("token不存在!");
    final now = DateTime.now().millisecondsSinceEpoch;
    if (tokenInfo.expiredAt < now) {
      // 清空缓存记录
      await _preferencesService.saveToken(null);
      return Failure("token已过期");
    }
    token = tokenInfo;
    return Success(null);
  }

  @override
  Future<Result<UserInfo>> getUserInfo() async {
    try {
      if (_token == null) {
        final rst = await _fetchToken();
        if (rst is Failure) return Failure("未登录");
      }
      // 如果是已登录状态，那么token一定是有的
      final rst = await _authClient.getUser(_token!.value);
      return Success(
        UserInfo(
          username: rst.username,
          password: rst.password,
          nickname: rst.nickname,
          avatarUrl: rst.avatarUrl,
          email: rst.email,
          token: _token!.value
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // 如果是认证信息失败，那么清空本地的token留存
        logout();
      }
      return Failure("网络错误：", e);
    } on Exception catch (e) {
      // 其他能不错误
      return Failure("服务错误：", e);
    }
  }

  @override
  Result<void> logout() {
    try {
      token = null;
      _preferencesService.saveToken(null);
      return Success(null);
    } on Exception catch (_) {
      return Failure("登出失败");
    }
  }
}
