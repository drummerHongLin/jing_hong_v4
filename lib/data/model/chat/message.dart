import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';

class Message {
  final int id;
  final int mId;
  final String content;
  final Role role;
  MsState state;
  String showingContent;
  final String sendTime;
  final int sId;

  Message({
    required this.id,
    required this.mId,
    required this.content,
    required this.role,
    required this.state,
    required this.showingContent,
    required this.sendTime,
    required this.sId,
  });

  factory Message.ready(int sid) {
    return Message(
      id: -1,
      mId: -1,
      content: '...',
      role: Role.assistant,
      state: MsState.ready,
      showingContent: '...',
      sendTime: '',
      sId: sid,
    );
  }

  factory Message.fromMap(Map<String, dynamic> m) {
    return Message(
      id: m['id'],
      mId: m['mId'],
      content: m['content'],
      role: Role.fromValue(m['role']) ?? Role.assistant,
      state: MsState.values.firstWhere(
        (state) => state.toString() == m['state'],
        orElse: () => MsState.completed,
      ),
      showingContent: m['content'],
      sendTime: m['sendTime'],
      sId: m['sessionId'],
    );
  }

  factory Message.manuallyStopped(String sendTime, int sId) {
    return Message(
      id: -1,
      mId: -1,
      content: "消息停止发送！",
      role: Role.assistant,
      state: MsState.stopped,
      showingContent: "消息停止发送！",
      sendTime: sendTime,
      sId: sId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mId': mId,
      'content': content,
      'role': role.value,
      'state': state.toString(),
      'showingContent': showingContent,
      'sendTime': sendTime,
      'sessionId': sId,
    };
  }

  Message readyVersion() {
    return Message(
      id: id,
      mId: mId,
      content: content,
      role: role,
      state: MsState.running,
      showingContent: "",
      sendTime: sendTime,
      sId: sId,
    );
  }

  Message subContent(int end) {
    return Message(
      id: id,
      mId: mId,
      content: content,
      role: role,
      state: MsState.running,
      showingContent: content.substring(0, end-1),
      sendTime: sendTime,
      sId: sId,
    );
  }
}
