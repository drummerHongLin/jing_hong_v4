import 'package:jing_hong_v4/data/data/chat/chat_repo.dart';
import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/utils/result.dart';

class ChatRepoLocal implements ChatRepo {
  @override
  Future<Result<void>> deleteSession(Session session) async {
    return Success(null);
  }

  @override
  Future<Result<List<Message>>> getHisMessagesBySession(Session session) async {
    return Success([
      Message(
        id: 1,
        mId: 1,
        content: "你好吗？",
        role: Role.user,
        state: MsState.completed,
        showingContent: "你好吗？",
        sendTime: '2025-06-13 11:12:13',
        sId: 1,
      ),
      Message(
        id: 1,
        mId: 2,
        content: "我很好！",
        role: Role.assistant,
        state: MsState.completed,
        showingContent: "我很好！",
        sendTime: '2025-06-13 11:12:14',
        sId: 1,
      ),
      Message(
        id: 1,
        mId: 3,
        content: "为什么好呢？",
        role: Role.user,
        state: MsState.completed,
        showingContent: "为什么好呢？",
        sendTime: '2025-06-13 11:12:15',
        sId: 1,
      ),
      Message(
        id: 1,
        mId: 4,
        content: "因为你在呀！",
        role: Role.assistant,
        state: MsState.completed,
        showingContent: "因为你在呀！",
        sendTime: '2025-06-13 11:12:16',
        sId: 1,
      ),
    ]);
  }

  @override
  Future<Result<List<Session>>> getHisSessionByModel(ChatModel model) async {
    return Success([
      Session(id: 1, title: "你好吗？", model: model.name),
      Session(id: 2, title: "你好吧？", model: model.name),
      Session(id: 3, title: "你好呢？", model: model.name),
    ]);
  }

  @override
  Future<Result<Message>> getMessageFromApi (
    List<Message> messages,
    ChatModel model,
  ) async {
    return Success(Message(
        id: 1,
        mId: messages.length+1,
        content: "因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！",
        role: Role.assistant,
        state: MsState.completed,
        showingContent: "因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！因为你在呀！",
        sendTime: '2025-06-13 11:22:16',
        sId: 1,
      ));
  }

  @override
  Future<Result<void>> saveMessage(Message message) async {
    return Success(null);
  }

  @override
  Future<Result<void>> saveSession(Session session) async {
    return Success(null);
  }
  @override
   Result<bool> switchModel(ChatModel model){

    return Success(true);
  }
}
