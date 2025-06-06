import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/home/model.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

class CvButton extends StatelessWidget {
  final CvInfo cvInfo;
  final TextStyle? cvStyle;

  const CvButton({super.key, required this.cvInfo, required this.cvStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // 后续增加点击从网络中下载文件功能
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: AppColors.active,
        shadowColor: AppColors.active,
        elevation: 3
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text("Download CV", style: cvStyle),
      ),
    );
  }
}
