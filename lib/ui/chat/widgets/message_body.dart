import 'dart:math' show max;

import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart'
    show ChatViewmodel;
import 'package:jing_hong_v4/ui/chat/widgets/message_list.dart';
import 'package:jing_hong_v4/ui/chat/widgets/send_func_area.dart';

class MessageBody extends StatelessWidget {
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
    required this.iconKey, required this.closePanel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
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
                    if (collapsed)
                      IconButton(
                        onPressed: openDrawer,
                        icon: Icon(Icons.vertical_split_outlined, size: 25),
                      ),
                    if (collapsed)
                      IconButton(
                        onPressed: () {
                          viewmodel.switchSession(null);
                          closePanel();
                        },
                        icon: Icon(Icons.add_circle_outline_outlined, size: 25),
                      ),
                    ValueListenableBuilder(
                      valueListenable: viewmodel.currentSession,
                      builder: (context, s, c) {
                        return Text(
                          s?.title ?? "",
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      },
                    ),
                  ],
                ),
                IconButton(
                  key: iconKey,
                  onPressed: openModelSelect,
                  icon: Icon(Icons.change_circle_outlined, size: 25),
                ),
              ],
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: viewmodel.loadMessages,
                builder: (c, cc) {
                  if (viewmodel.loadMessages.running) {
                    return Center(child: CircularProgressIndicator());
                  } else if (viewmodel.loadMessages.error) {
                    return Center(
                      child: TextButton.icon(
                        onPressed: () {
                          viewmodel.reloadMessages();
                          closePanel();
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
                  listenable: viewmodel.messageViewmodel,
                  builder:
                      (c, cc) => Padding(
                        padding:
                            isWide
                                ? EdgeInsets.symmetric(horizontal: width / 6)
                                : EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          spacing: 20,
                          children: [
                            MessageList(
                              sendedMessages:
                                  viewmodel.messageViewmodel.sendedMessages,
                              cachedMessage:
                                  viewmodel.messageViewmodel.cachedMessage,
                              maxWidth: width / 2,
                              maxHeight: height / 2,
                            ),
                            SendFuncArea(
                              height: 40,
                              width: max(width / 3, 400),
                              onSend: viewmodel.sendMessageManually,
                              viewmodel: viewmodel.messageViewmodel,
                              closePanel: closePanel,
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
