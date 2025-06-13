import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart';
import 'package:jing_hong_v4/ui/chat/widgets/message_body.dart';
import 'package:jing_hong_v4/ui/chat/widgets/session_panel.dart';

class ChatScreen extends StatefulWidget {
  final ChatViewmodel viewmodel;

  const ChatScreen({super.key, required this.viewmodel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  bool collapsed = false;

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void openDrawer() {
    controller.reverse().then((_) {
      setState(() {
        collapsed = false;
      });
    });
  }

  void closeDrawer() {
    controller.forward().then((_) {
      setState(() {
        collapsed = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return AnimatedBuilder(
          animation: animation,
          builder:
              (_, _) => Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: -300 * animation.value,
                    child: SessionPanel(
                      height: height,
                      width: 300,
                      viewmodel: widget.viewmodel,
                      closeDrawer: closeDrawer,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 300 * (1 - animation.value),
                    child: MessageBody(
                      height: height,
                      width: width -300 * (1 - animation.value),
                      viewmodel: widget.viewmodel,
                      collapsed: collapsed,
                      openDrawer: openDrawer,
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }

  Widget _buildInWide(BuildContext context) {
    //
    return Placeholder();
  }

  Widget _buildOutWide(BuildContext context) {
    return Placeholder();
  }
}
