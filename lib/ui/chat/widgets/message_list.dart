import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/model/chat/message.dart';
import 'package:jing_hong_v4/ui/chat/widgets/message_list_item.dart';

class MessageList extends StatefulWidget {
  final List<Message> sendedMessages;
  final Message? cachedMessage;

  final double maxWidth;

  final double maxHeight;


  final VoidCallback? onResend;

  final VoidCallback? onStop;

  const MessageList({
    super.key,
    required this.maxWidth, required this.sendedMessages,  this.cachedMessage, required this.maxHeight, this.onResend, this.onStop,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }


  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
             if (widget.sendedMessages.isEmpty) {
         return Image.asset(
            "assets/images/jinghong_logo.png",
            width: widget.maxWidth,
            height: widget.maxHeight,
          );
        } else {
          return        Expanded( 
        child: ListView(
          controller: controller,
          children: [
            for (var message in widget.sendedMessages)
              MessageListItem(message: message, maxWidth: widget.maxWidth,isCachedMessage: false,),
            if (widget.cachedMessage != null)
              MessageListItem(
                message: widget.cachedMessage!,
                maxWidth: widget.maxWidth,
                isCachedMessage: true,
                onResend: widget.onResend,
                onStop: widget.onStop,
              ),
          ],
        ),
      );
        } 
    
  }
}
