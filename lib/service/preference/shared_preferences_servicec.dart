import 'dart:convert';

import 'package:jing_hong_v4/service/preference/model/token_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 本地持久化存储，主要用于存储token等信息


class SharedPreferencesService {
    static const _tokenKey = 'TOKEN';

  Future<TokenInfo?> fetchToken() async{
    final sp = await SharedPreferences.getInstance(); 
    final tokenString = sp.getString(_tokenKey);
    if(tokenString == null){
      return null;
    }
    return TokenInfo.fromJson(jsonDecode(tokenString)); 
  }

  Future<void> saveToken(TokenInfo? token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if(token == null){
      await sharedPreferences.remove(_tokenKey);
    }
    else {
      await sharedPreferences.setString(_tokenKey,jsonEncode( token.toJson()));
    }
  }

}