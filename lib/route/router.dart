import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/route/routes.dart' show Routes;
import 'package:jing_hong_v4/ui/about/about_screen.dart';
import 'package:jing_hong_v4/ui/chat/chat_screen.dart';
import 'package:jing_hong_v4/data/local/route/data.dart' show navInfo;
import 'package:jing_hong_v4/ui/home/home_screen.dart';
import 'package:jing_hong_v4/ui/login/login_screen.dart';
import 'package:jing_hong_v4/ui/shell/custom_shell.dart';

// 用于弹出额外信息卡
CustomTransitionPage popPage(LocalKey key, Widget poppedScreen){
  return  CustomTransitionPage(
          key: key,
          child: poppedScreen,
          barrierDismissible: true,
          barrierColor: Colors.black38,
          opaque: false,
          transitionDuration: Duration.zero,
          transitionsBuilder: (_, __, ___, Widget child) => child,
        );
}

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        for (var n in navInfo)
          // 路由的位置暂时不设置动画，在每个界面这种单独设置符合界面的动画
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: n.path,
                builder: (context, state) {
                  return switch (n.path) {
                    "/home" => HomeScreen(),
                    "/chat" => ChatScreen(),
                    "/about" => AboutScreen(),
                    _ => HomeScreen(),
                  };
                },
              ),
            ],
          ),
      ],
      builder:
          (context, state, navigationShell) =>
              CustomShell(navs: navInfo, child: navigationShell),
    ),
    GoRoute(
      path: "/login",
      pageBuilder: (context, state) => popPage(state.pageKey,LoginScreen())
      ,
    ),
    GoRoute(
      path: "/SocialMedia/:id",
      pageBuilder: (context, state)  => popPage(state.pageKey, Placeholder()),
    ),
  ],
);
