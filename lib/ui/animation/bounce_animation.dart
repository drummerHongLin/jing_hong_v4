import 'package:flutter/material.dart';

/// 暂时先默认跳动方向为上下跳动
/// 如有需要，后续增加跳动方向参数控制跳动方向

class BounceAnimation extends StatelessWidget {
  final Widget child;
  late final Animation<double> _animation;

  BounceAnimation({
    super.key,
    required double bounceHeight,
    required Animation<double> parent,
    required this.child,
  }) : _animation = TweenSequence<double>([
         TweenSequenceItem(
           tween: Tween<double>(
             begin: 0,
             end: -bounceHeight,
           ).chain(CurveTween(curve: Curves.easeInOut)),
           weight: 1,
         ),
         TweenSequenceItem(
           tween: Tween<double>(
             begin: -bounceHeight,
             end: 0,
           ).chain(CurveTween(curve: Curves.easeInOut)),
           weight: 1,
         ),
       ]).animate(parent);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder:
          (context, child) => Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
          ),
      child: child,
    );
  }
}
