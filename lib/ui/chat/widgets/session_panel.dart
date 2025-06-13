import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/ui/animation/opacity_animation.dart'
    show OpacityAnimation;
import 'package:jing_hong_v4/ui/animation/slide_animation.dart'
    show SlideAnimation;
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

class SessionPanel extends StatelessWidget {
  final double height;
  final double width;
  final ChatViewmodel viewmodel;
  final GlobalKey<AnimatedListState> _listKey;
  final VoidCallback closeDrawer;

  SessionPanel({
    super.key,
    required this.height,
    required this.width,
    required this.viewmodel,
    required this.closeDrawer
  }) : _listKey = GlobalKey<AnimatedListState>() {
    viewmodel.createSession.addListener(addNewSession);
    viewmodel.loadSessions.addListener(clearList);
  }
  
  

  void addNewSession() {
    // 完成后插入
    if(viewmodel.createSession.completed){
         // 默认在第一个位置插入
      _addItem(0);
    }
  }

  void _addItem(int index) {
    _listKey.currentState?.insertItem(
      index,
      duration: const Duration(seconds: 1),
    );
  }

  void clearList() {
    viewmodel.createSession.removeListener(addNewSession);
    viewmodel.loadSessions.removeListener(clearList);
    _listKey.currentState?.removeAllItems((context, a) {
      return SizedBox.shrink();
    }, duration: Duration.zero);
  }

  Widget _buildListItem(
    Session session,
    Animation<double> animation,
    bool isWide, {
    bool isForward = true,
    bool isActivated = false,
  }) {
    return OpacityAnimation(
      parent: animation,
      isForward: isForward,
      child: SlideAnimation(
        begin: isForward ? Offset(-50, 0) : Offset.zero,
        end: isForward ? Offset.zero : Offset(-50, 0),
        parent: animation,
        child: 
        Padding(
          padding: EdgeInsets.only(bottom: 10),
           child: Text(
          session.title,
          style:
              isActivated
                  ? TextStyle(color: Colors.white)
                  : TextStyle(color: AppColors.active),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 监听当前模型变化
                    ListenableBuilder(
                      listenable: viewmodel.currentModel,
                      builder: (_, _) {
                        return SvgPicture.asset(
                          viewmodel.currentModel.value.iconUrl,
                          width: 30,
                          height: 30,
                        );
                      },
                    ),
                    IconButton(onPressed: closeDrawer, icon:  Icon(Icons.vertical_split_outlined, size: 25)),
                  ],
                ),
              ),
              IconButton.outlined(
                onPressed: () {
                  // 切换成空就行
                  viewmodel.switchSession(null);
                },
                icon: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Icon(Icons.add_circle_outline_outlined, size: 25),
                    Text(
                      "新建会话",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Icon(Icons.access_time_outlined, size: 25),
                    Text(
                      '历史会话',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListenableBuilder(
                  listenable: viewmodel.loadSessions,
                  builder: (context, child) {
                    if (viewmodel.loadSessions.running) {
                      return Center(child: CircularProgressIndicator());
                    } else if (viewmodel.loadSessions.error) {
                      return Center(
                        child: TextButton.icon(
                          onPressed: () {
                            viewmodel.reloadSessions();
                          },
                          label: Text("重新加载会话"),
                          icon: Icon(Icons.replay_outlined),
                        ),
                      );
                    } else {
                      return child!;
                    }
                  },
                  child: ListenableBuilder(
                    listenable: Listenable.merge([viewmodel.currentSession]),
                    builder:
                        (_, _) => Padding(
                          padding: EdgeInsets.only(left: 41),
                          child: AnimatedList(
                            key: _listKey,
                            initialItemCount: viewmodel.modelSessions.length,
                            itemBuilder: (context, index, a) {
                              if (index >= viewmodel.modelSessions.length) {
                                return SizedBox.shrink();
                              } else {
                                return _buildListItem(
                                  viewmodel.modelSessions[index],
                                  a,
                                  true,
                                  isActivated:
                                      viewmodel.modelSessions[index].id ==
                                      viewmodel.currentSession.value?.id,
                                );
                              }
                            },
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
