import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;

final List<String> qrPaths = [
  'assets/images/qr/qr-code-bytedance.jpg',
  'assets/images/qr/qr-code-wechat.jpg',
  'assets/images/qr/qr-code-github.png',
  'assets/images/qr/qr-code-email.png',
];

class SocialQrPanel extends StatelessWidget {
  final int index;

  const SocialQrPanel({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final qrPath =
        index >= qrPaths.length
            ? 'assets/images/qr/文件不存在提示.png'
            : qrPaths[index];

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Card(
          color: AppColors.active,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Image.asset(qrPath),
          ),
        ),
      ),
    );
  }
}
