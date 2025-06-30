import 'package:image_picker/image_picker.dart';
import 'package:jing_hong_v4/data/data/auth/auth_repo.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/utils/command.dart' show Command0;
import 'package:jing_hong_v4/utils/result.dart';

class AuthViewmodel {
  final AuthRepo _authRepo;

    late Command0<void> loadUserInfo;


  AuthViewmodel({required AuthRepo authRepo}) : _authRepo = authRepo{
    loadUserInfo = Command0(_loadUserInfo)..execute();
  }

  Future<Result<void>> login(UserInfo loginInfo) async {
    return await _authRepo.login(loginInfo.username, loginInfo.password);
  }

  Future<Result<void>> sendVerificationEmail(UserInfo registerInfo) async {
    return await _authRepo.sendVerificationEmail(
      registerInfo.username,
      registerInfo.password,
      registerInfo.nickname!,
      registerInfo.email!,
    );
  }

  Future<Result<void>> register(String username, String code) async {
    return await _authRepo.register(username, code);
  }

  Future<Result<void>> sendChangePasswordEmail(String username) async {
    return await _authRepo.sendChangePasswordEmail(username);
  }

  Future<Result<void>> changePassword(
    String username,
    String password,
    String code,
  ) async {
    return await _authRepo.changePassword(password, username, code);
  }


  Future<Result<UserInfo>> _loadUserInfo() async {
    return await _authRepo.getUserInfo();
  }

  Future<Result<void>> setAvatar(XFile file) async {
    final u = await _authRepo.getUserInfo();
    if(u is Failure) return u;
    
    final rst = await _authRepo.setAvatar((u as Success<UserInfo>).data.username, file);
    return rst;
  }
  

  Future<Result<void>> changePchangePasswordOnLoginassword(
    String password,
  ) async {
    final u = await _authRepo.getUserInfo();
    if(u is Failure) return u;

    return await _authRepo.changePasswordOnLogin(password, (u as Success<UserInfo>).data.username);
  }

}
