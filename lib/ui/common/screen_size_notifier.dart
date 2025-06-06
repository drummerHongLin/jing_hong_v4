

import 'package:flutter/material.dart' show BuildContext, InheritedWidget;

class ScreenSizeNotifier extends InheritedWidget {
  final bool isWide;
  final double minSize;

  const ScreenSizeNotifier( {
    super.key,
    required super.child,
    required this.isWide,
    required this.minSize,
  });

  static ScreenSizeNotifier? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScreenSizeNotifier>();
  }

  static ScreenSizeNotifier of(BuildContext context) {
    ScreenSizeNotifier? ssn = ScreenSizeNotifier.maybeOf(context);
    assert(ssn != null, "构建上下文中没有ScreenSize！");
    return ssn!;
  }

  @override
  bool updateShouldNotify(ScreenSizeNotifier oldWidget) {
    return isWide != oldWidget.isWide;
  }
}
