import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:jing_hong_v4/ui/animation/slide_animation.dart';
import 'package:jing_hong_v4/data/local/route/model.dart' show NavInfo;
import 'package:jing_hong_v4/ui/theme/colors.dart';

class BottomBarNav extends StatelessWidget {
  final List<NavInfo> navs;
  final StatefulNavigationShell child;
  final Animation<double> animation;

  const BottomBarNav({
    super.key,
    required this.navs,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      begin: Offset(0, 100),
      end: Offset.zero,
      parent: animation,
      child: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations:
            navs.indexed.map((t) {
              return NavigationDestination(
                icon: Icon(
                  t.$2.iconUrl,
                  size: t.$1 == child.currentIndex ? 30 : 20,
                  color: t.$1 == child.currentIndex ? AppColors.active : null,
                ),
                label: t.$2.name,
              );
            }).toList(),
        selectedIndex: child.currentIndex,
        onDestinationSelected: (value) => child.goBranch(value),
      ),
    );
  }
}
