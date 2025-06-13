import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/about/model.dart' show LifeExperience;
import 'package:jing_hong_v4/ui/about/widgets/millstone_image.dart';
import 'package:jing_hong_v4/ui/about/widgets/millstone_list.dart'
    show MillstoneList;
import 'package:jing_hong_v4/ui/common/circle_img.dart';

class MillstoneBody extends StatefulWidget {
  final bool isWide;
  final List<LifeExperience> life;
  final Animation<double> parentAnimation;

  const MillstoneBody({
    super.key,
    required this.isWide,
    required this.parentAnimation,
    required this.life,
  });

  @override
  State<MillstoneBody> createState() => _MillstoneBodyState();
}

class _MillstoneBodyState extends State<MillstoneBody> {
  late final Animation<double> animation;
  final ScrollController controller = ScrollController();
  late MillstoneList millstoneList;
  // 因为要在每个整数节点要进行插入操作，所以需要一个状态值记录当前整数节点
  int reachedMillStone = -1;

  @override
  void initState() {
    super.initState();
    animation = Tween<double>(
      begin: 0,
      end: widget.life.length.toDouble(),
    ).animate(widget.parentAnimation);
    millstoneList = MillstoneList(life: widget.life, isWide: widget.isWide);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animation.addListener(_forwardCallBack);
    });
  }

  @override
  void dispose() {
    reachedMillStone = -1;
    millstoneList.clearList();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MillstoneBody oldWidget) {
    reachedMillStone = -1;
    // 更新组件时 重新定义
    millstoneList = MillstoneList(life: widget.life, isWide: widget.isWide);
    super.didUpdateWidget(oldWidget);
  }

  void _forwardCallBack() {
    // 在每个整数节点的开始插入一个card对象
    if (animation.value < widget.life.length &&
        animation.value.toInt() > reachedMillStone) {
      reachedMillStone++;
      millstoneList.addItem(reachedMillStone);
      if (controller.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.linear,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: widget.isWide ? 60 : 20,
        ),
        child: Row(
          children: [
            _buildScrollList(),
            if (widget.isWide) _buildRelatedImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollList() {
    return Expanded(
      flex: 2,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: Center(
              child: CircleImg(
                imgFilePath: "assets/images/avatar-small.png",
                imgSize: Size(40, 40),
              ),
            ),
            title: Text("Hong's whole life"),
          ),
          millstoneList,
        ],
      ),
    );
  }

  Widget _buildRelatedImage() {
    return AnimatedBuilder(
      animation: animation,
      builder:
          (c, d) => Expanded(
            flex: 2,
            child: MillstoneImage(
              imageUrl:
                  reachedMillStone < 0
                      ? "assets/images/millstone.png"
                      : widget.life[reachedMillStone].url,
            ),
          ),
    );
  }
}
