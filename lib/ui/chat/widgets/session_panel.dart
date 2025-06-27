import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/route/routes.dart';
import 'package:jing_hong_v4/ui/animation/opacity_animation.dart'
    show OpacityAnimation;
import 'package:jing_hong_v4/ui/animation/slide_animation.dart'
    show SlideAnimation;
import 'package:jing_hong_v4/ui/chat/view_models/chat_viewmodel.dart';
import 'package:jing_hong_v4/ui/chat/widgets/session_list_item.dart'
    show SessionListItem;
import 'package:jing_hong_v4/ui/chat/widgets/user_panel.dart';

class SessionPanel extends StatefulWidget {
  final double height;
  final double width;
  final ChatViewmodel viewmodel;
  final VoidCallback closeDrawer;

  const SessionPanel({
    super.key,
    required this.height,
    required this.width,
    required this.viewmodel,
    required this.closeDrawer,
  });

  @override
  State<SessionPanel> createState() => _SessionPanelState();
}

class _SessionPanelState extends State<SessionPanel> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    widget.viewmodel.createSession.addListener(addNewSession);
  }

  @override
  void dispose() {
    widget.viewmodel.createSession.removeListener(addNewSession);
    super.dispose();
  }

  void addNewSession() {
    // 完成后插入
    if (widget.viewmodel.createSession.completed) {
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
        child: SessionListItem(
          isActivated: isActivated,
          onTap: () {
            widget.viewmodel.switchSession(session);
          },
          session: session,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Card(
        color: const Color.fromARGB(255, 21, 26, 35),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              // 展示model的icon和打开drawer的按钮
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 监听当前模型变化
                    ListenableBuilder(
                      listenable: widget.viewmodel.currentModel,
                      builder: (_, _) {
                        return SvgPicture.asset(
                          widget.viewmodel.currentModel.value.iconUrl,
                          width: 30,
                          height: 30,
                        );
                      },
                    ),
                    IconButton(
                      onPressed: widget.closeDrawer,
                      icon: Icon(Icons.vertical_split_outlined, size: 25),
                    ),
                  ],
                ),
              ),
              // 新建对话的按钮
              IconButton.outlined(
                onPressed: () {
                  // 切换成空就行
                  widget.viewmodel.switchSession(null);
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
              // 历史会话标题
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                    Text(
                      '历史会话',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              // 历史会话列表
              Expanded(
                child: ListenableBuilder(
                  listenable: widget.viewmodel.loadSessions,
                  builder: (context, child) {
                    if (widget.viewmodel.loadSessions.running) {
                      return Center(child: CircularProgressIndicator());
                    } else if (widget.viewmodel.loadSessions.error) {
                      return Center(
                        child: TextButton.icon(
                          onPressed: () {
                            widget.viewmodel.reloadSessions();
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
                    listenable: Listenable.merge([
                      widget.viewmodel.currentSession,
                    ]),
                    builder:
                        (_, _) => Padding(
                          padding: EdgeInsets.only(left: 41),
                          child: AnimatedList(
                            key: _listKey,
                            initialItemCount:
                                widget.viewmodel.modelSessions.length,
                            itemBuilder: (context, index, a) {
                              if (index >=
                                  widget.viewmodel.modelSessions.length) {
                                return SizedBox.shrink();
                              } else {
                                return _buildListItem(
                                  widget.viewmodel.modelSessions[index],
                                  a,
                                  true,
                                  isActivated:
                                      widget
                                          .viewmodel
                                          .modelSessions[index]
                                          .id ==
                                      widget.viewmodel.currentSession.value?.id,
                                );
                              }
                            },
                          ),
                        ),
                  ),
                ),
              ),
              // 登录信息
              ListenableBuilder(
                listenable: widget.viewmodel.loadUserInfo,
                builder: (ctx, child) {
                  if (widget.viewmodel.loadUserInfo.running) {
                    return SizedBox(
                      height: 40,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return child!;
                },
                child: ValueListenableBuilder(
                  valueListenable: widget.viewmodel.userInfo,
                  builder: (ctx, userInfo, c) {
                    final avatarUrl =
                        userInfo == null
                            ? 'https://ai-tang.oss-cn-shanghai.aliyuncs.com/jinghong/%E6%9C%AA%E7%99%BB%E5%BD%95.png'
                            : 'http://localhost:8080/v1/users/${userInfo.username}/get-avatar';
                    final nickName = userInfo?.nickname ?? '未登录';
                    final operationIcon =
                        userInfo == null
                            ? Icons.login_outlined
                            : Icons.logout_outlined;
                    final operation =
                        userInfo == null
                            ? () {
                              context
                                  .push(Routes.login)
                                  .then(
                                    (_) =>
                                        widget.viewmodel.loadUserInfo.execute(),
                                  );
                            }
                            : widget.viewmodel.logout;

                    final headers =
                        userInfo == null
                            ? null
                            : <String, String>{
                              "Authorization": "Bearer ${userInfo.token}",
                            };

                    return UserPanel(
                      avatarUrl: avatarUrl,
                      nickname: nickName,
                      operationIcon: operationIcon,
                      operation: operation,
                      headers: headers,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
