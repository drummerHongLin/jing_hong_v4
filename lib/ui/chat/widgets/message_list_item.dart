import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';

class MessageListItem extends StatelessWidget {
  final Message message;

  // maxWidth随消息区域大小动态变化的
  final double maxWidth;

  const MessageListItem({
    super.key,
    required this.message,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == Role.user;

    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isUser) _buildAvatar(isUser),
        _buildMessage(isUser),
        if (isUser) _buildAvatar(isUser),
      ],
    );
  }

  Widget _buildAvatar(bool isUser) {
    return SvgPicture.asset(
      isUser ? "assets/images/Naruto.svg" : "assets/images/robot.svg",
      width: 30,
      height: 30,
    );
  }

  Widget _buildMessage(bool isUser) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Card(child: Text(message.showingContent)),
        ],
      ),
    );
  }
}
