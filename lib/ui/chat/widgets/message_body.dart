import 'dart:math' show max;

import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models/chat_viewmodel.dart'
    show ChatViewmodel;
import 'package:jing_hong_v4/ui/chat/widgets/message_list.dart';
import 'package:jing_hong_v4/ui/chat/widgets/send_func_area.dart';

class MessageBody extends StatefulWidget {
  final double height;
  final double width;
  final bool collapsed;
  final bool isWide;
  final ChatViewmodel viewmodel;
  final VoidCallback openDrawer;
  final VoidCallback openModelSelect;
  final VoidCallback closePanel;
  final GlobalKey iconKey;

  const MessageBody({
    super.key,
    required this.height,
    required this.width,
    required this.viewmodel,
    required this.collapsed,
    required this.openDrawer,
    required this.isWide,
    required this.openModelSelect,
    required this.iconKey,
    required this.closePanel,
  });

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.collapsed)
                      IconButton(
                        onPressed: widget.openDrawer,
                        icon: Icon(Icons.vertical_split_outlined, size: 25),
                      ),
                    if (widget.collapsed)
                      IconButton(
                        onPressed: () {
                          widget.viewmodel.switchSession(null);
                          widget.closePanel();
                        },
                        icon: Icon(Icons.add_circle_outline_outlined, size: 25),
                      ),
                    ValueListenableBuilder(
                      valueListenable: widget.viewmodel.currentSession,
                      builder: (context, s, c) {
                        return Text(
                          s?.title ?? "",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                        );
                      },
                    ),
                  ],
                ),
                IconButton(
                  key: widget.iconKey,
                  onPressed: widget.openModelSelect,
                  icon: Icon(Icons.change_circle_outlined, size: 25),
                ),
              ],
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.viewmodel.loadMessages,
                builder: (c, cc) {
                  if (widget.viewmodel.loadMessages.running) {
                    return Center(child: CircularProgressIndicator());
                  } else if (widget.viewmodel.loadMessages.error) {
                    return Center(
                      child: TextButton.icon(
                        onPressed: () {
                          widget.viewmodel.reloadMessages();
                          widget.closePanel();
                        },
                        label: Text("重新加载消息"),
                        icon: Icon(Icons.replay_outlined),
                      ),
                    );
                  } else {
                    return cc!;
                  }
                },
                child: ListenableBuilder(
                  listenable: widget.viewmodel.messageViewmodel,
                  builder:
                      (c, cc) => Padding(
                        padding:
                            widget.isWide
                                ? EdgeInsets.symmetric(
                                  horizontal: widget.width / 6,
                                )
                                : EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          spacing: 20,
                          children: [
                            MessageList(
                              sendedMessages:
                                  widget
                                      .viewmodel
                                      .messageViewmodel
                                      .sendedMessages,
                              cachedMessage:
                                  widget
                                      .viewmodel
                                      .messageViewmodel
                                      .cachedMessage,
                              maxWidth:
                                  widget.width *
                                  (widget.isWide ? 1 / 2 : 2 / 3),
                              maxHeight:
                                  widget.height *
                                  (widget.isWide ? 1 / 2 : 2 / 3),
                              onResend: widget.viewmodel.resendMessage,
                              onStop: widget.viewmodel.stopSendMessage,
                            ),
                            SendFuncArea(
                              height: 40,
                              width: max(widget.width / 3, 400),
                              onSend: widget.viewmodel.sendMessageManually,
                              viewmodel: widget.viewmodel.messageViewmodel,
                              closePanel: widget.closePanel,
                            ),
                          ],
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
