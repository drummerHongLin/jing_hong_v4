import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/about/model.dart' show LifeExperience;
import 'package:jing_hong_v4/ui/about/widgets/millstone_card.dart' show MillstoneCard;
import 'package:jing_hong_v4/ui/animation/opacity_animation.dart' show OpacityAnimation;
import 'package:jing_hong_v4/ui/animation/slide_animation.dart' show SlideAnimation;

class MillstoneList extends StatelessWidget{


  late final GlobalKey<SliverAnimatedListState> _listKey;

  final List<LifeExperience> life;
  final bool isWide;


  MillstoneList({super.key, required this.life, required this.isWide}):_listKey  =
      GlobalKey<SliverAnimatedListState>();


  void addItem(int reachedMillStone) {
    _listKey.currentState?.insertItem(
      reachedMillStone,
      duration: const Duration(seconds: 1),
    );
  }

  void clearList() {
    _listKey.currentState?.removeAllItems((context, a) {
      return SizedBox.shrink();
    }, duration: Duration.zero);
  }


  
  Widget _buildListItem(
    LifeExperience lifeExperience,
    Animation<double> animation,
    bool isWide, {
    bool isForward = true,
  }) {
    return OpacityAnimation(
      parent: animation,
      isForward: isForward,
      child: SlideAnimation(
        begin: isForward ? Offset(-50, 0) : Offset.zero,
        end: isForward ? Offset.zero : Offset(-50, 0),
        parent: animation,
        child: MillstoneCard(lifeExperience: lifeExperience, isWide: isWide),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: _listKey,
      itemBuilder: (context, index, animation) {
        if (index >= life.length) {
          return SizedBox.shrink();
        } else {
          return _buildListItem(life[index], animation, isWide);
        }
      },
    );
  }

  

}