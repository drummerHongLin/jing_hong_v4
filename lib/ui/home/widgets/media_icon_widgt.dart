import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/data/local/home/model.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

class MediaIconWidgt extends StatefulWidget {
  final MediaIcon mediaIcon;
  final double size;
  final int index;

  const MediaIconWidgt({
    super.key,
    required this.mediaIcon,
    required this.size,
    required this.index
  });

  @override
  State<MediaIconWidgt> createState() => _MediaIconWidgtState();
}

class _MediaIconWidgtState extends State<MediaIconWidgt> {
  Color mainColor = AppColors.active;
  Color suffColor = AppColors.bg;

  @override
  void initState() {
    super.initState();
  }

  void _onHover(bool b) {
    setState(() {
      if (b) {
        mainColor = AppColors.bg;
        suffColor = AppColors.active;
      } else {
        suffColor = AppColors.bg;
        mainColor = AppColors.active;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) => _onHover(value),
      onTap: () {context.push("/socialMedia/${widget.index}");},
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: suffColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.active, width: 2),
          boxShadow: [
            BoxShadow(
              color: suffColor,
              offset: Offset.zero,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            widget.mediaIcon.icon,
            color: mainColor,
            size: widget.size * 0.6,
          ),
        ),
      ),
    );
  }
}
