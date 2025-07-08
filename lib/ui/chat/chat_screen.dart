import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models/chat_viewmodel.dart';
import 'package:jing_hong_v4/ui/chat/widgets/message_body.dart';
import 'package:jing_hong_v4/ui/chat/widgets/model_panel.dart';
import 'package:jing_hong_v4/ui/chat/widgets/session_panel.dart';
import 'package:jing_hong_v4/ui/common/screen_size_notifier.dart';

class ChatScreen extends StatefulWidget {
  final ChatViewmodel viewmodel;

  const ChatScreen({super.key, required this.viewmodel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  bool collapsed = false;
  bool showModelSelect = false;
  Offset modelSelectOffset = Offset.zero;
  bool isWide = false;

  final GlobalKey iconKey = GlobalKey();
  final GlobalKey containerKey = GlobalKey();

  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller);
    widget.viewmodel.msgNotifier.addListener(showSnackBar);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    widget.viewmodel.onViewChange();
    closeModelSelect();
    super.didChangeDependencies();
    isWide = ScreenSizeNotifier.of(context).isWide;
    if (isWide) {
      collapsed = false;
      controller.animateTo(0, duration: Duration.zero);
    } else {
      collapsed = true;
      controller.animateTo(1, duration: Duration.zero);
    }
  }

  @override
  void didUpdateWidget(covariant ChatScreen oldWidget) {
    widget.viewmodel.onViewChange();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.viewmodel.onViewChange();
    controller.dispose();
    widget.viewmodel.msgNotifier.removeListener(showSnackBar);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 在应用退出时保存相关信息
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden || state == AppLifecycleState.paused) {
      widget.viewmodel.onViewChange();
    }

    super.didChangeAppLifecycleState(state);
  }

  void openModelSelect() {
    if (!showModelSelect) {
      setState(() {
        getIconPosition();
        showModelSelect = true;
      });
    } else {
      closeModelSelect();
    }
  }

  void closeModelSelect() {
    if (showModelSelect) {
      setState(() {
        showModelSelect = false;
      });
    }
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



  void getIconPosition() {
    RenderBox? renderBox =
        iconKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? containerBox =
        containerKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      Offset offset = renderBox.localToGlobal(
        Offset.zero,
        ancestor: containerBox,
      );
      modelSelectOffset = Offset(offset.dx, offset.dy);
    }
  }

  void closePanel() {
    if (!isWide && !collapsed) {
      closeDrawer();
    }
    if (showModelSelect) {
      closeModelSelect();
    }
  }

  void showSnackBar({String? msg}){

    final content = msg??widget.viewmodel.msgNotifier.msg;

    final snackBar = SnackBar(content: Text(content??""));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    isWide = ScreenSizeNotifier.of(context).isWide;
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return AnimatedBuilder(
          animation: animation,
          builder:
              (_, _) => Stack(
                key: containerKey,
                children: [
                  Positioned(
                    top: 0,
                    left: isWide ? 300 * (1 - animation.value) : 0,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: closePanel,
                      child: MessageBody(
                        height: height,
                        width:
                            isWide
                                ? width - 300 * (1 - animation.value)
                                : width,
                        viewmodel: widget.viewmodel,
                        collapsed: collapsed,
                        openDrawer: openDrawer,
                        openModelSelect: openModelSelect,
                        closePanel: closePanel,
                        isWide: isWide,
                        iconKey: iconKey,
                      ),
                    ),
                  ),
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
                  if (showModelSelect)
                    ModelPanel(
                      onModelTap: (m) {
                        closeModelSelect();
                        widget.viewmodel.switchModel(m);
                      },
                      panelOffset: modelSelectOffset,
                    ),
                ],
              ),
        );
      },
    );
  }
}
