import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/animation/bounce_animation.dart';
import 'package:jing_hong_v4/ui/animation/scale_animation.dart';
import 'package:jing_hong_v4/ui/common/circle_img.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

class HomeAvatar extends StatelessWidget {
  final Animation<double> animation1;
  final Animation<double> animation2;
  final double avatarSize;

  const HomeAvatar({
    super.key,
    required this.avatarSize,
    required this.animation1,
    required this.animation2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleAnimation(
        parent: animation1,
        child: BounceAnimation(
          bounceHeight: avatarSize/20,
          parent: animation2,
          child: 
          CircleImg(
            imgFilePath: "assets/images/avatar.png",
            imgSize: Size(avatarSize, avatarSize),
            boxShadow: [BoxShadow(
              color: AppColors.active,
              offset: Offset.zero,
              blurRadius: avatarSize/20,
              spreadRadius: 1,
            )],
          ),
        ),
      ),
    );
  }
}
