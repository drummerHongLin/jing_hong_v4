import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/service/db/chat_db.dart';

class RemoteDb extends ChatDb {
  final Dio client;
  bool isAuthorized = false;

  RemoteDb({String? baseUrl})
    : client = Dio(
        BaseOptions(baseUrl: baseUrl ?? "https://www.honghouse.cn/api/v1/chat/"),
      );

  void afterLogin(Map<String,String> header) {
      client.options.headers.addEntries(header.entries);
      isAuthorized = true;
  }

  void afterLogout() {
    client.options.headers.remove("Authorization");
    isAuthorized = false;
  }

  @override
  Future<void> close() async {
    return;
  }

  @override
  Future<void> deleteSession(String id) async {
    // 远程服务器设置了级联效应，所以只用调用删除session的接口就行了
    await client.put("/delete-session/$id");
  }

  @override
  Future<List<Message>> getMessageBySessionId(String sessionId) async {
    final rst = await client.get("/get-messages/$sessionId");
    final messages = (rst.data['messages'] as List<dynamic>);
    final returnMessages = messages.map((m) => Message.fromMap(m)).toList();
    return returnMessages;
  }

  @override
  Future<List<Session>> getSessionsByModel(ChatModel model) async {
    final rst = await client.get("/get-sessions/${model.name}");
    final sessions = (rst.data['sessions'] as List<dynamic>);
    final returnSessions = sessions.map((s) => Session.fromMap(s)).toList();
    return returnSessions;
  }

  @override
  Future<int> insertMessage(List<Message> message) async {
    final body = jsonEncode(message.map((m)=>m.toMap()).toList());

    await client.post("create-new-message", data: body);

    // 这个后面再调整
    return 1;
  }

  @override
  Future<int> insertSession(List<Session> session) async {
    final body = jsonEncode(session.map((s)=>s.toMap()).toList());
    await client.post("create-new-session", data: body);
    return 1;
  }
  
  @override
  Future<List<Message>> getAllMessages() async{
    final rst = await client.get("/get-all-messages");
    final messages = (rst.data['messages'] as List<Map<String, dynamic>>);
    final returnMessages = messages.map((m) => Message.fromMap(m)).toList();
    return returnMessages;
  }
  
  @override
  Future<List<Session>> getAllSessions() async {
    final rst = await client.get("/get-all-sessions");
    final sessions = (rst.data['sessions'] as List<Map<String, dynamic>>);
    final returnSessions = sessions.map((s) => Session.fromMap(s)).toList();
    return returnSessions;
  }
}
