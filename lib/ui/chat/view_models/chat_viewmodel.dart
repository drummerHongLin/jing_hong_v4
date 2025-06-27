// 主要是加载动作的状态记录
// 控制界面的加载遮挡
// 提供界面的当前session和model的值变动提示

import 'dart:async';
import 'dart:math' show min;

import 'package:async/async.dart' show CancelableOperation;
import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/data/auth/auth_repo.dart';
import 'package:jing_hong_v4/data/data/chat/chat_repo.dart';
import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';
import 'package:jing_hong_v4/data/data/chat/local/chat_model.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/ui/chat/view_models/message_viewmodel.dart';
import 'package:jing_hong_v4/utils/command.dart';
import 'package:jing_hong_v4/utils/msg_notifier.dart';
import 'package:jing_hong_v4/utils/result.dart';
import 'package:intl/intl.dart';

class ChatViewmodel {
  // 数据来源提供
  final ChatRepo _chatRepo;
  final AuthRepo _authRepo;
  // 耗时操作命令，加载历史消息和历史会话
  late Command1<void, Session> loadMessages;
  late Command1<void, ChatModel> loadSessions;
  late Command1<Session, String?> createSession;
  late Command0<void> loadUserInfo;

  ChatViewmodel({required ChatRepo chatRepo, required AuthRepo authRepo})
    : _chatRepo = chatRepo,
      _authRepo = authRepo {
    loadMessages = Command1(_loadMessages);
    loadSessions = Command1(_loadSessions)..execute(currentModel.value);
    createSession = Command1<Session, String?>(_createSession);
    loadUserInfo = Command0(_loadUserInfo)..execute();
  }

  // 用于进行消息提示
  MsgNotifier msgNotifier = MsgNotifier();

  // 这一部分的核心状态是当前选择的模型和当前的会话

  ValueNotifier<Session?> currentSession = ValueNotifier(null);

  ValueNotifier<ChatModel> currentModel = ValueNotifier(chatModels[0]);

  // 保留用户信息
  ValueNotifier<UserInfo?> userInfo = ValueNotifier(null);

  List<Session> modelSessions = [];

  final MessageViewmodel _messageViewmodel = MessageViewmodel();
  MessageViewmodel get messageViewmodel => _messageViewmodel;

  CancelableOperation<Result<Message>>? _apiOperation;

  // 相关的操作
  // 1. 创建会话 - 根据新的title创建新会话，并将数据信息保存到数据库；
  // 2. 保存消息 - ready消息排除，消息加入历史消息列表，并将数据信息保存到数据库;
  // 3. 处理缓存消息 - 停止打印缓存消息，保存缓存消息；
  // 4. 发送消息 - 设置缓存消息为ready消息， 通过历史消息列表向服务器请求数据，请求完成后，返回的消息设置成缓存消息 ；
  // 5. 停止消息 - 如果消息在running状态，则停止打印； 如果消息是ready状态，停止api请求，设置缓存消息为手动停止消息；
  // 6. 手动发送消息 - 处理缓存消息，保存发送消息，发送消息；
  // 7. 重试发送消息 - 直接发送消息；
  // 8. 加载历史消息 - 在repo获取历史消息的基础上，增加错误消息的展示处理， 设置历史对话列表为获取到的历史消息数据；
  // 9. 切换会话 - 停止消息，处理缓存消息，
  //      选择session为空的话，历史消息设置为emptyList,缓存消息设置为空
  //      切换currentSession为选择的session，加载历史消息，
  //             - 如果历史消息最后一个是用户消息，那么发送消息；
  //             - 如果历史消息最后一个是running状态，那么重新打印消息；
  // 10. 加载历史会话 - 在repo获取历史消息的基础上，增加错误消息的展示处理， 设置会话列表为获取到的历史消息数据；
  // 11. 切换模型 - 加载历史会话，切换会话为空会话；

  // 1. 创建会话
  Future<Result<Session>> _createSession(String? title) async {
    final newSession = Session(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title ?? '新建会话',
      model: currentModel.value.name,
    );

    modelSessions.insert(0, newSession);

    final rst = await _chatRepo.saveSession(newSession);

    if (rst is Failure) msgNotifier.msg = rst.message;

    // 加入动画结束后执行
    Timer(Duration(milliseconds: 1200), () {
      currentSession.value = newSession;
    });

    return Success(newSession);
  }

  // 2. 保存消息
  Future<void> saveMessage(Message message) async {
    if (message.state != MsState.ready) {
      _messageViewmodel.addMessage(message);
      final rst = await _chatRepo.saveMessage(message);
      if (rst is Failure) msgNotifier.msg = rst.message;
    }
    return;
  }

  // 3. 处理缓存消息
  Future<void> handleCachedMessage({bool saveRunning = false}) async {
    if (_messageViewmodel.cachedMessage != null) {
      _messageViewmodel.stopType(saveRunning: saveRunning);
      await saveMessage(_messageViewmodel.cachedMessage!);
    }
    return;
  }

  // 4. 发送消息 异步请求包在CancelableOperation中
  void sendMessage(Session cs) {
    assert(_messageViewmodel.sendedMessages.isNotEmpty);
    final lastSendedMessage = _messageViewmodel.sendedMessages.last;
    _messageViewmodel.setCachedMessage(Message.ready(cs.id));
    _apiOperation = CancelableOperation<Result<Message>>.fromFuture(
      _chatRepo.getMessageFromApi(
        _messageViewmodel.sendedMessages,
        currentModel.value,
      ),
      onCancel: () {
        _messageViewmodel.setCachedMessage(
          Message.manuallyStopped(
            lastSendedMessage.sendTime,
            lastSendedMessage.sId,
          ),
        );
        msgNotifier.msg = "网络请求被中止！";
      },
    );
    _apiOperation!.value.then((r) {
      r.when(
        success: (r) => _messageViewmodel.typeMessage(r),
        failure: (msg, err) {
          msgNotifier.msg = err.toString();
        },
      );
    });
  }

  // 5. 停止消息
  void stopSendMessage() {
    _apiOperation?.cancel();
    _messageViewmodel.stopType();
  }

  // 6. 手动发送消息
  Future<void> sendMessageManually(String message) async {
    final sendTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

    var session = currentSession.value;

    if (session == null) {
      await createSession.execute(
        message.substring(0, min(message.length, 10)),
      );
      var cs = createSession.result as Result<Session>;
      if (cs is Failure) return;
      cs = cs as Success<Session>;
      session = cs.data;
    }

    final messageToSend = Message(
      id: DateTime.now().millisecondsSinceEpoch,
      mId: _messageViewmodel.sendedMessages.length,
      content: message,
      role: Role.user,
      state: MsState.completed,
      showingContent: message,
      sendTime: sendTime,
      sId: session.id,
    );
    await handleCachedMessage();
    await saveMessage(messageToSend);
    sendMessage(session);
  }

  // 7. 重新发送消息
  void resendMessage() {
    if (currentSession.value == null) {
      msgNotifier.msg = "会话未被创建";
    } else {
      sendMessage(currentSession.value!);
    }
  }

  // 8. 加载历史消息
  Future<Result<void>> _loadMessages(Session session) async {
    final rst = await _chatRepo.getHisMessagesBySession(session);
    rst.when(
      success: (msgs) {
        final signal = _messageViewmodel.setSendedMessages(msgs);
        switch (signal) {
          case true:
            // 判断是否最后一条消息是用户发出
            resendMessage();
          default:
            break;
        }
      },
      failure: (msg, err) => msgNotifier.msg = msg + err.toString(),
    );
    return rst;
  }

  // 9. 切换会话
  Future<void> switchSession(Session? session) async {
    onViewChange();
    if (session != null) {
      loadMessages.execute(session);
    } else {
      _messageViewmodel.clearMessage();
    }
    currentSession.value = session;
  }

  // 10. 加载历史会话
  Future<Result<void>> _loadSessions(ChatModel model) async {
    final rst = await _chatRepo.getHisSessionByModel(model);
    rst.when(
      success: (msgs) {
        modelSessions = msgs;
      },
      failure: (msg, err) => msgNotifier.msg = msg + err.toString(),
    );
    return rst;
  }

  // 11. 切换模型
  Future<void> switchModel(ChatModel model) async {
    final rst = _chatRepo.switchModel(model);
    if (rst is Failure) return;
    currentModel.value = model;
    await loadSessions.execute(model);
    await switchSession(null);
  }

  // 12. 重新加载会话
  void reloadSessions() {
    loadSessions.execute(currentModel.value);
  }

  // 13. 重新加载消息
  void reloadMessages() {
    if (currentSession.value != null) {
      loadMessages.execute(currentSession.value!);
    }
  }

  // 14. 页面更新或退出时，停止消息的打印，并保存缓存信息
  void onViewChange() {
    _apiOperation?.cancel();
    handleCachedMessage(saveRunning: true);
    _messageViewmodel.setCachedMessage(null);
  }

  // 登录用户信息模块
  // 15. 载入用户信息
  Future<Result<void>> _loadUserInfo() async {
    final rst = await _authRepo.getUserInfo();
    rst.when(
      success: (data) {
        userInfo.value = data;
        return Success(null);
      },
      failure: (msg, e) {
        // 如果获取失败清空当前用户信息
        userInfo.value = null;
        msgNotifier.msg = msg;
        return Failure(msg);
      },
    );
    return Success(null);
  }

  // 16. 登出 （登录的功能放在专门的登录界面）
  void logout() {
    _authRepo.logout();
    loadUserInfo.execute();
  }
}
