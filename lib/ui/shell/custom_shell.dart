import 'dart:math' show min;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Builder,
        Column,
        EdgeInsets,
        Expanded,
        MediaQuery,
        Padding,
        SafeArea,
        Scaffold,
        StatefulWidget,
        State,
        Widget;

import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:jing_hong_v4/data/local/route/model.dart' show NavInfo;
import 'package:jing_hong_v4/ui/shell/widgets/bottom_bar_nav.dart';
import 'package:jing_hong_v4/ui/common/screen_size_notifier.dart';
import 'package:jing_hong_v4/ui/shell/widgets/top_bar_nav.dart' show TopBarNav;


class CustomShell extends StatefulWidget {
  final StatefulNavigationShell child;
  final List<NavInfo> navs;

  const CustomShell({super.key, required this.child, required this.navs});

  @override
  State<CustomShell> createState() => _CustomShellState();
}

class _CustomShellState extends State<CustomShell>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideUpAnimation;

  final _delayMillseconds = 100;
  final _runMillseconds = 500;

  @override
  void initState() {
    super.initState();

    // 动画的运动时间写死
    final totalAnimationDuration = Duration(
      milliseconds:
          (widget.navs.length - 1) * _delayMillseconds + _runMillseconds,
    );
    _animationController = AnimationController(
      duration: totalAnimationDuration,
      vsync: this,
    );
    _slideUpAnimation = 
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0,
          _runMillseconds / totalAnimationDuration.inMilliseconds,
        ),
      );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reset();
          Future.delayed(Duration(milliseconds: 500),(){  _animationController.forward();});
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width / size.height > 1 && size.height >= 600;
    return SafeArea(
      child: Scaffold(
        body: ScreenSizeNotifier(
          isWide: isWide,
          minSize:min(size.width , size.height),
          child: Builder(
            builder: (innerContext) => _buildShellBody(innerContext),
          ),
        ),
      ),
    );
  }

  Widget _buildShellBody(BuildContext context) {
    final isWide = ScreenSizeNotifier.of(context).isWide;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isWide ? 20 : 0,
        horizontal: isWide ? 100 : 20,
      ),
      child: Column(
        children: [
          if (isWide)
            TopBarNav(
              navs: widget.navs,
              animation: _animationController,
              delayMillseconds: _delayMillseconds,
              runMillseconds: _runMillseconds,
              child: widget.child,
            ),
          Expanded(child: widget.child),
          if (!isWide)
            BottomBarNav(
              navs: widget.navs,
              animation: _slideUpAnimation,
              child: widget.child,
            ),
        ],
      ),
    );
  }
}
