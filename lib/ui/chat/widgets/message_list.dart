import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/message_viewmodel.dart';
import 'package:jing_hong_v4/ui/chat/widgets/message_list_item.dart';

class MessageList extends StatefulWidget {
  final MessageViewmodel viewmodel;

  final double maxWidth;

  const MessageList({
    super.key,
    required this.viewmodel,
    required this.maxWidth,
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
    widget.viewmodel.addListener(_scrollToBottom);
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
    widget.viewmodel.removeListener(_scrollToBottom);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewmodel,
      builder: (context, child) {
        if (widget.viewmodel.sendedMessages.isEmpty) {
          return Image.asset(
            "assets/images/chengdu.jpg",
            width: widget.maxWidth,
          );
        }
        return child!;
      },
      child: Expanded(
        child: ListView(
          children: [
            for (var message in widget.viewmodel.sendedMessages)
              MessageListItem(message: message, maxWidth: widget.maxWidth),
            if (widget.viewmodel.cachedMessage != null)
              MessageListItem(
                message: widget.viewmodel.cachedMessage!,
                maxWidth: widget.maxWidth,
              ),
          ],
        ),
      ),
    );
  }
}
