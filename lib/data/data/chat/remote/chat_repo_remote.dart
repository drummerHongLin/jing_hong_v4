import 'package:dio/dio.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:jing_hong_v4/data/data/chat/chat_repo.dart';
import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/service/api/chat/chat_client.dart' show ChatClient;
import 'package:jing_hong_v4/service/api/chat/model/chat_api_data.dart';
import 'package:jing_hong_v4/service/db/chat_db.dart';
import 'package:jing_hong_v4/service/db/remote_db.dart';
import 'package:jing_hong_v4/service/db/sqlite_db.dart';
import 'package:jing_hong_v4/utils/result.dart';
import 'package:jing_hong_v4/utils/tools.dart';

class ChatRepoRemote implements ChatRepo {
  final ChatClient _chatClient;
  final SqliteDb _sqliteDb;
  final RemoteDb _remoteDb;

  // 在provider中实现依赖注入
  ChatRepoRemote({
    required ChatClient chapClient,
    required SqliteDb sqliteDb,
    required RemoteDb remoteDb,
  }) : _chatClient = chapClient,
       _sqliteDb = sqliteDb,
       _remoteDb = remoteDb;

  // 为vm提供数据服务
  // 数据请求的错误处理统一放在这一部分处理
  // 数据服务分为两部分 1. 从数据库中获取历史数据；2. 从api端口中获取新的对话信息(api端口的数据暂时不用stream);

  // 0. 根据登录情况获取用哪个数据库

  ChatDb getAccessibleDb() {
    if (_remoteDb.isAuthorized) {
      return _remoteDb;
    } else {
      return _sqliteDb;
    }
  }

  // 会话操作
  // 1. 通过模型获取会话信息
  @override
  Future<Result<List<Session>>> getHisSessionByModel(ChatModel model) async {
    try {
      ChatDb db = getAccessibleDb();

      final sessions = await db.getSessionsByModel(model);
      return Success(sessions);
    } catch (e) {
      return Failure("获取指定模型会话列表失败", e);
    }
  }

  // 2. 保存会话信息到数据库
  @override
  Future<Result<void>> saveSession(Session session) async {
    try {
      ChatDb db = getAccessibleDb();
      await db.insertSession([session]);
      return Success(null);
    } catch (e) {
      return Failure("保存会话失败:${e.toString()}", e);
    }
  }

  // 3. 删除会话信息
  @override
  Future<Result<void>> deleteSession(Session session) async {
    try {
      ChatDb db = getAccessibleDb();
      await db.deleteSession(session.id);
      return Success(null);
    } catch (e) {
      return Failure("删除会话失败", e);
    }
  }

  // 消息操作
  // 1. 根据会话获取历史消息记录
  @override
  Future<Result<List<Message>>> getHisMessagesBySession(Session session) async {
    try {
      ChatDb db = getAccessibleDb();
      final messages = await db.getMessageBySessionId(session.id);
      return Success(messages);
    } catch (e) {
      return Failure("获取信息失败", e);
    }
  }

  // 2. 保存消息到历史消息记录
  @override
  Future<Result<void>> saveMessage(Message message) async {
    try {
      ChatDb db = getAccessibleDb();
      await db.insertMessage([message]);
      return Success(null);
    } catch (e) {
      return Failure("保存消息失败:${e.toString()}", e);
    }
  }

  // 3. 从api获取新的消息
  @override
  Future<Result<Message>> getMessageFromApi(
    List<Message> messages,
    ChatModel model,
    String? username,
  ) async {
    final lastMessage = messages.last;
    try {
      final requestMessages =
          messages
              .map(
                (msg) =>
                    RequestMessage(role: msg.role.value, content: msg.content),
              )
              .toList();
      final requestBody = RequestBody(
        model: model.version,
        messages: requestMessages,
      );
      final resp = await _chatClient.getChatCompletion(requestBody);
      final newMessage = Message(
        id: Tools.generateUuid("message", username),
        mId: lastMessage.mId + 1,
        content: resp.choices.first.message.content,
        role: Role.assistant,
        state: MsState.completed,
        showingContent: resp.choices.first.message.content,
        sendTime: DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
        sId: lastMessage.sId,
      );
      return Success(newMessage);
    } on DioException catch (e) {
      // 网络异常是可预见的异常
      final newMessage = Message(
        id: Tools.generateUuid("message", username),
        mId: lastMessage.mId + 1,
        content: e.toString(),
        role: Role.assistant,
        state: MsState.completed,
        showingContent: e.toString(),
        sendTime: DateTime.now().toIso8601String(),
        sId: lastMessage.sId,
      );
      return Success(newMessage);
    } catch (e) {
      return Failure("获取消息失败", e);
    }
  }

  // 4. 更新模型
  @override
  Result<bool> switchModel(ChatModel model) {
    _chatClient.setChatModel(model.name);
    return Success(true);
  }

  // 5. 从本地把数据转移到线上
  // 每次登录时操作
  @override
  Future<Result<void>> transferData() async {
    // 后面需要改
    // 取本地的所有session
    final localSessions = await _sqliteDb.getAllSessions();

    if (localSessions.isNotEmpty) {
      await _remoteDb.insertSession(localSessions);
    }

    // 取本地的所有消息

    final localMessages = await _sqliteDb.getAllMessages();
    if (localMessages.isNotEmpty) {
      await _remoteDb.insertMessage(localMessages);
    }

    await _sqliteDb.truncate();
    return Success(null);
  }
}
