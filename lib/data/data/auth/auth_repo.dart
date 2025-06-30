import 'package:image_picker/image_picker.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/service/preference/model/token_info.dart';
import 'package:jing_hong_v4/utils/result.dart';

abstract class AuthRepo {


    TokenInfo? get token;

    // 在代码内部存储token信息
    Future<Result<void>> login(String username, String password);
    // 这一步实际是要先调用注册接口，在服务端注册客户
    Future<Result<void>> sendVerificationEmail(String username,String password,String nickname,String email);
    // 这一步实际是要先调用注册接口，在服务端注册客户
    Future<Result<void>> sendChangePasswordEmail(String username);
    // 这一步需要先验证验证码，然后获取用户信息，在代码内部存储token信息
    Future<Result<void>> register(String username, String code);
    // 更改密码，这个是在忘记密码的情况下更改密码
    Future<Result<void>> changePassword(String newPassword,String username,String code);
    // 登录状态下更改密码
    Future<Result<void>> changePasswordOnLogin(String newPassword, String username);
    // 如果有留存token，且token有效，那么直接可以获取用户信息
    Future<Result<UserInfo>> getUserInfo() ;
    // 登出
    Result<void> logout();
    // 待完成 获取 avatar相关信息
    // 设置头像

    Future<Result<void>> setAvatar(String username, XFile file);
    

}