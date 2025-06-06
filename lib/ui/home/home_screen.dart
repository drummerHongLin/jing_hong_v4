import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/local/home/data.dart';
import 'package:jing_hong_v4/ui/common/screen_size_notifier.dart'
    show ScreenSizeNotifier;
import 'package:jing_hong_v4/ui/home/widgets/home_avatar.dart';
import 'package:jing_hong_v4/ui/home/widgets/self_introduction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late AnimationController _bounceAnimationController;
   late AnimationController _slideAnimationController2;

  final _totalAnimationDuration = Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _slideAnimationController = AnimationController(
      duration: _totalAnimationDuration * (0.5),
      vsync: this,
    );

    _slideAnimationController2 = AnimationController(
      duration: _totalAnimationDuration * (0.5),
      vsync: this,
    );


    _bounceAnimationController = AnimationController(
      duration: _totalAnimationDuration,
      vsync: this,
    );
    _slideAnimationController.addStatusListener(_slideToBounceListener);
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    _slideAnimationController.removeStatusListener(_slideToBounceListener);
    _bounceAnimationController.dispose();
    _slideAnimationController2.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {


    if (_slideAnimationController.status == AnimationStatus.completed) {
      _slideAnimationController.reset();
      Future.delayed(Duration(milliseconds: 500), () {
        _slideAnimationController.forward();
      });
    }

    super.didChangeDependencies();
  }

  void _slideToBounceListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _bounceAnimationController.repeat();
      _slideAnimationController2.forward();
    }
    if (status == AnimationStatus.dismissed) {
      _bounceAnimationController.reset();
      _slideAnimationController2.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = ScreenSizeNotifier.of(context).isWide;
    final minSize = ScreenSizeNotifier.of(context).minSize;
    final items = _generateHomeItems(minSize, isWide);
    return isWide ? Row(children: items) : Column(children: items);
  }

  List<Widget> _generateHomeItems(double minSize, bool isWide) {
    return [
      Expanded(
        child: HomeAvatar(
          animation1: _slideAnimationController,
          animation2: _bounceAnimationController,
          avatarSize: minSize / 2,
        ),
      ),
      Expanded(
        child: SelfIntroduction(
          titles: [],
          mediaIcons: mediaIcons,
          animation1: _slideAnimationController,
          animation2: _slideAnimationController2,
          isWide: isWide,
        ),
      ),
    ];
  }
}
