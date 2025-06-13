import 'package:jing_hong_v4/data/model/chat/chat_model.dart' show ChatModel;
import 'package:jing_hong_v4/data/model/chat/message.dart' show Message;
import 'package:jing_hong_v4/data/model/chat/session.dart' show Session;
import 'package:jing_hong_v4/utils/result.dart' show Result;

abstract class ChatRepo {
  Future<Result<List<Session>>> getHisSessionByModel(ChatModel model);

  // 2. 保存会话信息到数据库
  Future<Result<void>> saveSession(Session session);

  // 3. 删除会话信息
  Future<Result<void>> deleteSession(Session session);

  // 消息操作
  // 1. 根据会话获取历史消息记录
  Future<Result<List<Message>>> getHisMessagesBySession(Session session);

  // 2. 保存消息到历史消息记录
  Future<Result<void>> saveMessage(Message message);

  // 3. 从api获取新的消息
  Future<Result<Message>> getMessageFromApi(
    List<Message> messages,
    ChatModel model,
  );
}
