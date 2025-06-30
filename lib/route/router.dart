import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/data/data/auth/remote/auth_repo_remote.dart'
    show AuthRepoRemote;
import 'package:jing_hong_v4/data/local/route/data.dart' show navInfo;
import 'package:jing_hong_v4/route/routes.dart' show Routes;
import 'package:jing_hong_v4/ui/about/about_screen.dart';
import 'package:jing_hong_v4/ui/auth/forget_password/forget_screen.dart';
import 'package:jing_hong_v4/ui/auth/login/login_screen.dart';
import 'package:jing_hong_v4/ui/auth/profile/profile_screen.dart';
import 'package:jing_hong_v4/ui/auth/profile/widgets/add_avatar.dart';
import 'package:jing_hong_v4/ui/auth/profile/widgets/change_password.dart';
import 'package:jing_hong_v4/ui/auth/register/register_screen.dart';
import 'package:jing_hong_v4/ui/chat/chat_screen.dart';
import 'package:jing_hong_v4/ui/home/home_screen.dart';
import 'package:jing_hong_v4/ui/shell/custom_shell.dart';
import 'package:provider/provider.dart';

// 用于弹出额外信息卡
CustomTransitionPage popPage(LocalKey key, Widget poppedScreen) {
  return CustomTransitionPage(
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
                    "/chat" => ChatScreen(viewmodel: context.read()),
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
      path: "/users",
      builder: (context, state) => Center(child: Text("404 页面不存在!")),
      routes: [
        GoRoute(
          path: "/login",
          pageBuilder:
              (context, state) => popPage(
                state.pageKey,
                LoginScreen(viewmodel: context.read()),
              ),
        ),
        GoRoute(
          path: "/register",
          pageBuilder:
              (context, state) => popPage(
                state.pageKey,
                RegisterScreen(viewmodel: context.read()),
              ),
        ),
        GoRoute(
          path: "/forget-password",
          pageBuilder:
              (context, state) => popPage(
                state.pageKey,
                ForgetScreen(viewmodel: context.read()),
              ),
        ),
        GoRoute(
          path: "/profile",
          pageBuilder: (context, state) {
            return popPage(
              state.pageKey,
              ProfileScreen(viewmodel: context.read()),
            );
          },
          redirect: (context, state) {
            final token = context.read<AuthRepoRemote>().token;
            // 先做一次判断，如果token失效转到登录页面
            if (token == null) {
              return "/users/login";
            }
            return null;
          },
          routes: [
            // 放在这可以共用上级的重定向
            GoRoute(
              path: "/set-avatar",
              pageBuilder: (context, state) => popPage(state.pageKey, AddAvatar(viewmodel: context.read())),
            ),
                        GoRoute(
              path: "/change-password",
              pageBuilder: (context, state) => popPage(state.pageKey, ChangePassword(viewmodel: context.read())),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/socialMedia/:id",
      pageBuilder: (context, state) => popPage(state.pageKey, Placeholder()),
    ),
  ],
);
