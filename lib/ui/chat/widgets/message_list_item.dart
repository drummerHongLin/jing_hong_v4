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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) _buildAvatar(isUser),
        _buildMessage(isUser,context),
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

  Widget _buildMessage(bool isUser,BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.symmetric(horizontal:10),child: Text(message.sendTime,style: Theme.of(context).textTheme.labelSmall,),),
          Card(
            color: const Color.fromARGB(125, 31, 36, 45),
            child: Padding(padding: EdgeInsets.all(10), child:  Text(message.showingContent))),
        ],
      ),
    );
  }
}
