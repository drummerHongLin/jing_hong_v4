import 'dart:io';

import 'package:jing_hong_v4/data/local/chat/basic_info.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/service/api/chat/chat_client.dart' show ChapClient;
import 'package:jing_hong_v4/service/api/chat/model/chat_api_data.dart';
import 'package:jing_hong_v4/service/db/chat/chat_db.dart';
import 'package:jing_hong_v4/utils/result.dart';

class ChatRepo {
  final ChapClient _chapClient;
  final ChatDb _chatDb;

  // 在provider中实现依赖注入
  ChatRepo({required ChapClient chapClient, required ChatDb chatDb})
    : _chapClient = chapClient,
      _chatDb = chatDb;

  // 为vm提供数据服务
  // 数据请求的错误处理统一放在这一部分处理
  // 数据服务分为两部分 1. 从数据库中获取历史数据；2. 从api端口中获取新的对话信息(api端口的数据暂时不用stream);

  // 会话操作
  // 1. 通过模型获取会话信息
  Future<Result<List<Session>>> getHisSessionByModel(ChatModel model) async {
    try {
      final sessions = await _chatDb.getSessionsByModel(model);
      return Success(sessions);
    } catch (e) {
      return Failure("获取指定模型会话列表失败", e);
    }
  }

  // 2. 保存会话信息到数据库
  Future<Result<void>> saveSession(Session session) async {
    try {
      await _chatDb.insertSession(session);
      return Success(null);
    } catch (e) {
      return Failure("保存会话失败", e);
    }
  }

  // 3. 删除会话信息
  Future<Result<void>> deleteSession(Session session) async {
    try {
      await _chatDb.deleteSession(session.id);
      await _chatDb.deleteMessagesBySessionId(session.id);
      return Success(null);
    } catch (e) {
      return Failure("删除会话失败", e);
    }
  }

  // 消息操作
  // 1. 根据会话获取历史消息记录
  Future<Result<List<Message>>> getHisMessagesBySession(Session session) async {
    try {
      final messages = await _chatDb.getMessageBySessionId(session.id);
      return Success(messages);
    } catch (e) {
      return Failure("获取信息失败", e);
    }
  }

  // 2. 保存消息到历史消息记录
  Future<Result<void>> saveMessage(Message message) async {
    try {
      await _chatDb.insertMessage(message);
      return Success(null);
    } catch (e) {
      return Failure("保存消息失败", e);
    }
  }

  // 3. 从api获取新的消息
  Future<Result<Message>> getMessageFromApi(
    List<Message> messages,
    ChatModel model,
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
      final resp = await _chapClient.getChatCompletion(requestBody);
      final newMessage = Message(
        id: lastMessage.id + 1,
        mId: lastMessage.mId + 1,
        content: resp.choices.first.message.content,
        role: Role.assistant,
        state: MsState.completed,
        showingContent: resp.choices.first.message.content,
        sendTime: DateTime.now().toIso8601String(),
        sId: lastMessage.sId,
      );
      return Success(newMessage);
    } 
    on IOException catch (e) {
      // 网络异常是可预见的异常
      final newMessage = Message(
        id: lastMessage.id + 1,
        mId: lastMessage.mId + 1,
        content: e.toString(),
        role: Role.assistant,
        state: MsState.completed,
        showingContent: e.toString(),
        sendTime: DateTime.now().toIso8601String(),
        sId: lastMessage.sId,
      );
      return Success(newMessage);
    }
    catch (e) {
      return Failure("获取消息失败", e);
    }
  }
}
