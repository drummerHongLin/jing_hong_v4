import 'package:flutter/material.dart';

/// 用于创建滑动类组件
/// 需要传入滑动的开始位置和结束位置
/// 运动的时间轨迹暂时默认为EaseInOut，后续有需要再调整
/// 需要传入 运动的控制器，用于控制运动的开始和结束

class SlideAnimation extends StatelessWidget {
  final Widget child;
  late final Animation<Offset> _animation;

  SlideAnimation({
    super.key,
    required Offset begin,
    required Offset end,
    required Animation<double> parent,
    required this.child,
  }) : _animation = Tween<Offset>(
         begin: begin,
         end: end,
       ).animate(CurvedAnimation(parent: parent, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(offset: _animation.value, child: child);
      },
      child: child,
    );
  }
}


/// 生成滑动时间不一致的滑动动画组
List<Widget> generateSlideGroup(
  Offset begin,
  Offset end,
  int delayMillseconds,
  int runMillseconds,
  Animation<double> parent,
  List<Widget> children,
) {
  assert(children.isNotEmpty, "至少需要一个运动组件");
  final l = children.length;
  List<Widget> slideAnimations = [];
  final totalDuration = Duration(
    milliseconds: (children.length - 1) * delayMillseconds + runMillseconds,
  );
  for (int i = 0; i < l; i++) {
    slideAnimations.add(
      SlideAnimation(
        begin: begin,
        end: end,
        parent: CurvedAnimation(
          parent: parent,
          curve: Interval(
            i * delayMillseconds / totalDuration.inMilliseconds,
            (i * delayMillseconds + runMillseconds) /
                totalDuration.inMilliseconds,
          ),
        ),
        child: children[i],
      ),
    );
  }
  return slideAnimations;
}
