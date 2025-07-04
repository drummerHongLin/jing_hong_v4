import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';

abstract class ChatDb {
  
  Future<int> insertSession(List<Session> session);

  // 2. 根据model获取session列表
  Future<List<Session>> getSessionsByModel(ChatModel model);

  // 3. 删除session
  Future<void> deleteSession(String id);

  // 4. 插入消息
  Future<int> insertMessage(List<Message> message) ;
  

  // 5. 通过会话id获取消息
  Future<List<Message>> getMessageBySessionId(String sessionId) ;

  // 6. 获取所有会话信息

  Future<List<Session>> getAllSessions();


  // 6. 获取所有信息

  Future<List<Message>> getAllMessages();


  // 关闭数据库链接
  Future<void> close() ;

}