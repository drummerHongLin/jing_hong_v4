import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;

class ProcessIndicator extends StatelessWidget {

  final Animation<double> animation;
  final int totalMillstone;

   ProcessIndicator({
    super.key,
    required this.totalMillstone,
    required Animation<double> parentAnimation
  }): animation = Tween<double>(begin: 0,end: totalMillstone.toDouble()).animate(parentAnimation);

  @override
  Widget build(BuildContext context) {
    // 动效采用重绘操作，重绘的数值由animation控制
    return 
    AnimatedBuilder(animation: animation, builder: (c,d)=>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 10,
        width: double.infinity,
        child: CustomPaint(
          painter: ShapePainter(
            process: animation.value/totalMillstone,
            reachedMillStone: animation.value.toInt(),
            totalMillstone: totalMillstone,
          ),
        ),
      ),
    ));
  }
}

class ShapePainter extends CustomPainter {
  final double process;
  final int reachedMillStone;
  final int totalMillstone;

  ShapePainter({
    super.repaint,
    required this.process,
    required this.reachedMillStone,
    required this.totalMillstone,
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

    for (int i = 1; i <= totalMillstone; i++) {
      circleCenter = Offset(i * rectWidth / totalMillstone, rectHeight / 2);
      // 绘制圆形
      canvas.drawCircle(
        circleCenter,
        circleRadius,
        i > reachedMillStone ? paint : reachedPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) =>
      oldDelegate.process != process;
}
