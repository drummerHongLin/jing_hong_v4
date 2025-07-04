import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/home/data.dart';
import 'package:jing_hong_v4/data/local/home/model.dart';
import 'package:jing_hong_v4/ui/animation/opacity_animation.dart';
import 'package:jing_hong_v4/ui/animation/scale_animation.dart';
import 'package:jing_hong_v4/ui/animation/slide_animation.dart';
import 'package:jing_hong_v4/ui/home/widgets/cv_button.dart';
import 'package:jing_hong_v4/ui/home/widgets/media_icon_widgt.dart';

class SelfIntroduction extends StatelessWidget {
  final greeting1 = "Hello,It's Me";
  final greeting2 = "Call Me Honglin";
  final List<String> titles;
  final ambition =
      "Do not forget the lofty aspirations you set during your youth, where you were determined to become a top-tier figure in the world.";
  final List<MediaIcon> mediaIcons;
  final Animation<double> animation1;
  final Animation<double> animation2;
  final bool isWide;

  const SelfIntroduction({
    super.key,
    required this.titles,
    required this.mediaIcons,
    required this.animation1,
    required this.animation2,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;

    TextStyle? greeting1Style =
        isWide ? localTheme.headlineLarge : localTheme.headlineSmall;
    TextStyle? greeting2Style =
        isWide ? localTheme.displayLarge : localTheme.displaySmall;
    TextStyle? titlesStyle =
        isWide ? localTheme.headlineLarge : localTheme.headlineSmall;
    TextStyle? ambitionStyle =
        isWide ? localTheme.labelLarge : localTheme.labelSmall;
    TextStyle? cvStyle =
        isWide ? localTheme.headlineMedium : localTheme.labelLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: isWide ? 10 : 5,
        children: [
          OpacityAnimation(
            parent: animation1,
            child: SlideAnimation(
              begin: Offset(0, -50),
              end: Offset.zero,
              parent: animation1,
              child: Text(
                greeting1,
                style: greeting1Style?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          OpacityAnimation(
            parent: animation1,
            child:
          SlideAnimation(
            begin: Offset(-100, 0),
            end: Offset.zero,
            parent: animation1,
            child: Text(
              greeting2,
              style: greeting2Style?.copyWith(fontWeight: FontWeight.bold),
            ),
          )),
          OpacityAnimation(
            parent: animation1,
            child:SlideAnimation(
            begin: Offset(0, 50),
            end: Offset.zero,
            parent: animation1,
            child: Text(
              "And I'm a Full-Stack Engineer",
              style: titlesStyle?.copyWith(fontWeight: FontWeight.bold),
            ),
          )),
          ScaleAnimation(
            parent: animation1,
            child: Text(
              ambition,
              style: ambitionStyle?.copyWith(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: generateSlideGroup(
                Offset(0, 100),
                Offset.zero,
                100,
                500,
                animation1,
                _generateMediaIcons(),
              ),
            ),
          ),
          ScaleAnimation(
            parent: CurvedAnimation(
              parent: animation2,
              curve: Interval(0, 0.5),
            ),
            child: CvButton(
              cvInfo: cvInfo,
              cvStyle: cvStyle?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _generateMediaIcons() {
    return [
      for (int i =0; i <mediaIcons.length; i++)
        OpacityAnimation(
            parent: animation1,
            child:MediaIconWidgt(mediaIcon: mediaIcons[i], size: isWide ? 60 : 40, index: i,)),
    ];
  }
}
