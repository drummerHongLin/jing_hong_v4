import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart'
    show ChatViewmodel;
import 'package:jing_hong_v4/ui/chat/widgets/message_list.dart';
import 'package:jing_hong_v4/ui/chat/widgets/send_func_area.dart';

class MessageBody extends StatelessWidget {
  final double height;
  final double width;
  final bool collapsed;
  final ChatViewmodel viewmodel;
  final VoidCallback openDrawer;

  const MessageBody({
    super.key,
    required this.height,
    required this.width,
    required this.viewmodel,
    required this.collapsed,
    required this.openDrawer,
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
                      IconButton(onPressed: (){viewmodel.switchSession(null);},icon:  Icon(Icons.add_circle_outline_outlined, size: 25)),
                    ValueListenableBuilder(
                        valueListenable: viewmodel.currentSession,
                        builder: (context, s, c) {
                          return 
                          Text(s?.title??"", style: Theme.of(context).textTheme.labelMedium,);
                        },
                      ),
                  ],
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.change_circle_outlined, size: 25)),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  MessageList(viewmodel: viewmodel.messageViewmodel, maxWidth: width/2),
                  SendFuncArea(
                    height: 40,
                    width: width / 2,
                    onSend: viewmodel.sendMessageManually,
                    viewmodel: viewmodel.messageViewmodel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
