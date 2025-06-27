import 'package:jing_hong_v4/data/data/auth/auth_repo.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/utils/result.dart';





class AuthViewmodel {
  final AuthRepo _authRepo;



  AuthViewmodel({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<Result<void>> login(UserInfo loginInfo) async {
    return await _authRepo.login(loginInfo.username, loginInfo.password);
  }

  Future<Result<void>> sendVerificationEmail(UserInfo registerInfo) async {

    return await _authRepo.sendVerificationEmail(registerInfo.username, registerInfo.password, registerInfo.nickname!, registerInfo.email!);

  }

  Future<Result<void>> register(String username, String  code) async {
    return await _authRepo.register(username, code);
  }

}
