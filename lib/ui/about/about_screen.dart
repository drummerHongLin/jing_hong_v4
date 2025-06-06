import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/about/data.dart';
import 'package:jing_hong_v4/ui/about/widgets/millstone_body.dart';
import 'package:jing_hong_v4/ui/about/widgets/process_indicator.dart';
import 'package:jing_hong_v4/ui/common/screen_size_notifier.dart'
    show ScreenSizeNotifier;

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  // 动画的控制器统一放主界面处理，以实现不同子组件的同步
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500 * myLife.length),
    );

    //  需要等widget构建后，key挂上scrolllist后再进行增加操作
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Timer(Duration(milliseconds: 1500), () {
        if (mounted) {
          _animationController.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.reset();
    _animationController.forward();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final isWide = ScreenSizeNotifier.of(context).isWide;

    return Column(
      children: [
        MillstoneBody(
          isWide: isWide,
          parentAnimation: _animationController,
          life: myLife,
        ),
        ProcessIndicator(
          parentAnimation: _animationController,
          totalMillstone: myLife.length,
        ),
      ],
    );
  }
}
