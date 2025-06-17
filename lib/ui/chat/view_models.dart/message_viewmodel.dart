// 消息发送和接受，以及打印效果的状态
// 控制消息的增加和减少

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';

class MessageViewmodel extends ChangeNotifier {
  // 消息vm主要有两个
  // sendedMessages 和 cachedMessage
  // 这两个不单独设置Notifier，因为一个变化都会导致整个消息列表的变化
  // 两个变量的主体都设置成私有变量，get和set方法单独设置，这样方便设置notifyListeners的时机
  List<Message> _sendedMessages = [];

  List<Message> get sendedMessages => _sendedMessages;

  Message? _cachedMessage;

  Message? get cachedMessage => _cachedMessage;

  // 用于回去打印机定时器
  Timer? _job;

  // 消息需要执行的操作有
  // 1. 设置缓存消息和历史消息 - 已经在set方法中实现
  // 2. 加入消息到历史消息 - 二级函数是将缓存消息加到历史消息中去
  // 3. 打印缓存消息 - 设置打印任务，任务结束后改变缓存消息状态
  // 4. 停止打印消息
  // 消息的操作都建立在已经获取到消息的情况下，获取消息的动作交给整个界面的vm操作

  void addMessage(Message message) {
    // 这个动作不会通知，因为一般给历史消息增加记录有其他对应的动作
    _sendedMessages.add(message);
  }

  void saveCachedMessage() {
    if (_cachedMessage != null) {
      addMessage(_cachedMessage!);
      setCachedMessage(null);
    }
  }

  void setCachedMessageState(MsState state) {
    if (_cachedMessage != null) {
      _cachedMessage!.state = state;
      notifyListeners();
    }
  }

  // 打印功能通过不断改变缓存消息的内容实现，采用固定间隔的定时器
  void typeMessage(Message message) {
    // 如果不是完成态的消息则直接显示，比如错误
    if (message.state == MsState.completed ||
        message.content.length > message.showingContent.length) {
      int index = 0;
      if (message.state == MsState.completed) {
        setCachedMessage(message.readyVersion());
      } else {
        index = message.showingContent.length;
        setCachedMessage(message);
      }

      _job = Timer.periodic(Duration(milliseconds: 100), (t) {
        // 设置退出条件
        if (_cachedMessage!.showingContent == message.content) {
          message.state = MsState.completed;
          message.showingContent = message.content;
          setCachedMessage(message);
          t.cancel();
        } else {
          index++;
          setCachedMessage(message.subContent(index));
        }
      });
    } else {
      setCachedMessage(message);
    }
  }

  void stopType({bool saveRunning = false}) {
    if (_job?.isActive??false ) {
      _job!.cancel();
      setCachedMessageState(saveRunning?MsState.running: MsState.stopped);
    }
  }

  void setCachedMessage(Message? message) {
    _cachedMessage = message;
    notifyListeners();
  }

  bool setSendedMessages(List<Message> messages) {
    _sendedMessages = messages;
    _cachedMessage = null;
    if (messages.last.role == Role.user) {
      return true;
    } else if (messages.last.state == MsState.running) {
      _sendedMessages = messages.sublist(0, messages.length - 1);
      typeMessage(messages.last);
      return false;
    } else {
      notifyListeners();
      return false;
    }
  }

  void clearMessage() {
    _cachedMessage = null;
    _sendedMessages = [];
    notifyListeners();
  }
}
