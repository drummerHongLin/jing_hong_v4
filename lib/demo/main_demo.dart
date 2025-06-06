import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late final AnimationController _animation;

  late final Animation<double> _animationT;

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animationT = Tween<double>(begin: 0, end: 1).animate(_animation);

    _animation.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.bg,
        appBar: AppBar(title: const Text('矩形与圆形相连图形')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Expanded(child: Placeholder()),
            SizedBox(
              height: 10,
              width: double.infinity,
              child: AnimatedBuilder(
                animation: _animationT,
                builder: (c, d) {
                  return CustomPaint(
                    painter: ShapePainter(
                      process: _animationT.value,
                      reachedMillStone: _animationT.value ~/ 0.25,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final double process;
  final int reachedMillStone;

  ShapePainter({
    super.repaint,
    required this.process,
    required this.reachedMillStone,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white; // 设置画笔颜色
    final Paint reachedPaint = Paint()..color = AppColors.active; // 设置画笔颜色

    // 定义矩形参数（宽300，高12）
    double rectWidth = size.width;
    const double rectHeight = 6;
    // 矩形位置：左上角在 (0, 0)（为了让图形居中，实际绘制时可以调整偏移）
    final Rect rect = Rect.fromLTWH(0, 0, rectWidth, rectHeight);

    final Rect reachedRect = Rect.fromLTWH(
      0,
      0,
      rectWidth * process,
      rectHeight,
    );

    // 绘制矩形
    canvas.drawRect(rect, paint);

    canvas.drawRect(reachedRect, reachedPaint);

    // 定义圆形参数（直径15，半径7.5）
    const double circleRadius = 7.5;

    // 圆形中心位置：矩形右侧末端（x=rectWidth） + 半径（circleRadius），y与矩形中心对齐（rectHeight/2）
    Offset circleCenter;

    for (int i = 1; i < 5; i++) {
      circleCenter = Offset(i * rectWidth / 4, rectHeight / 2);
      // 绘制圆形
      canvas.drawCircle(
        circleCenter,
        circleRadius,
        i > reachedMillStone ? paint : reachedPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) => oldDelegate.process != process;
}
