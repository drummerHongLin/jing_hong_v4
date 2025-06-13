import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart'
    show ChatViewmodel;

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
    required this.openDrawer
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(collapsed)
                  IconButton(onPressed: openDrawer, icon: Icon(Icons.vertical_split_outlined,size: 25,)),
                if(collapsed)
                  Icon(Icons.add_circle_outline_outlined,size: 25,),
                if(viewmodel.currentSession.value != null)
                  Text(viewmodel.currentSession.value!.title)
              ],
            ),
            Icon(Icons.change_circle_outlined,size: 25)
          ],
        ), Expanded(child: Center(
          child: Text('消息列表'),
        ))]),
      ),
    );
  }
}
