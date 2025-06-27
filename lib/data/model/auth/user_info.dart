class UserInfo {

  final String username;
  final String password;
  final String? nickname;
  final String? avatarUrl;
  final String? email;
  final String? token;

  UserInfo({required this.username, required this.password,  this.nickname,  this.avatarUrl,  this.email, this.token});
  
}