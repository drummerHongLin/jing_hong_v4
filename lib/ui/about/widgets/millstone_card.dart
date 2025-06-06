import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/about/model.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';


class MillstoneCard extends StatelessWidget {
  // 当前时间段的信息
  final LifeExperience lifeExperience;
  final bool isWide;

  const MillstoneCard({
    super.key,
    required this.lifeExperience,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    TextStyle? contentStyle =
        isWide ? localTheme.headlineSmall : localTheme.labelMedium;
    return Card(
      color: AppColors.bg.withValues(alpha: 0.7),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          spacing: 10,
          children: [
            Icon(lifeExperience.icon, color: Colors.white),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(lifeExperience.date),
                  Text(lifeExperience.content, style: contentStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
