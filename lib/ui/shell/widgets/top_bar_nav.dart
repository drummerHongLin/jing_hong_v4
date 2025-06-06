import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:jing_hong_v4/ui/animation/slide_animation.dart' show generateSlideGroup;
import 'package:jing_hong_v4/data/local/route/model.dart' show NavInfo;
import 'package:jing_hong_v4/ui/shell/widgets/text_nav_item.dart';

class TopBarNav extends StatelessWidget {
  final List<NavInfo> navs;
  final StatefulNavigationShell child;
  final Animation<double> animation;
  final int delayMillseconds;
  final int runMillseconds;

  const TopBarNav({
    super.key,
    required this.navs,
    required this.animation,
    required this.delayMillseconds,
    required this.runMillseconds,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final children = _generateSlideTab(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextNavItem(
          title: 'JingHong',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          isActived: false,
        ),
        Row(
          spacing: 15,
          children: generateSlideGroup(
            Offset(0, 100),
            Offset.zero,
            delayMillseconds,
            runMillseconds,
            animation,
            children,
          ),
        ),
      ],
    );
  }

  List<Widget> _generateSlideTab(BuildContext context) {
    return [
      for (int i = 0; i < navs.length; i++)
        TextNavItem(
          title: navs[i].name,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          isActived: i == child.currentIndex,
          func: () {
            child.goBranch(i);
          },
        ),
    ];
  }
}
