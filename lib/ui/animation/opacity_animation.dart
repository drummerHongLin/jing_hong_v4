
import 'package:flutter/material.dart';

class OpacityAnimation extends StatelessWidget {
  final Widget child;
  late final Animation<double> _animation;

  OpacityAnimation({
    super.key,
    required Animation<double> parent,
    required this.child,
    bool isForward = true
  }) : _animation = Tween<double>(
         begin: isForward? 0:1,
         end: isForward? 1: 0,
       ).animate(CurvedAnimation(parent: parent, curve: Curves.easeInOut));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(opacity: _animation.value,child: child,);
      },
      child: child,
    );
  }
}