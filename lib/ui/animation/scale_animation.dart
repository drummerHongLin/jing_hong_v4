import 'package:flutter/material.dart';

/// 用于创建滑动类组件
/// 需要传入滑动的开始位置和结束位置
/// 运动的时间轨迹暂时默认为EaseInOut，后续有需要再调整
/// 需要传入 运动的控制器，用于控制运动的开始和结束

class ScaleAnimation extends StatelessWidget {
  final Widget child;
  late final Animation<double> _animation;

  ScaleAnimation({
    super.key,
    required Animation<double> parent,
    required this.child,
  }) : _animation = Tween<double>(
         begin: 0,
         end: 1,
       ).animate(CurvedAnimation(parent: parent, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(scale: _animation.value, child: child);
      },
      child: child,
    );
  }
}