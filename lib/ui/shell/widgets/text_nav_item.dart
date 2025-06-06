import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

class TextNavItem extends StatefulWidget {
  final TextStyle? style;
  final String title;
  final Function()? func;
  final bool isActived;

  const TextNavItem({
    super.key,
    this.style,
    required this.title,
    this.func,
    required this.isActived,
  });

  @override
  State<TextNavItem> createState() => _TextNavItemState();
}

class _TextNavItemState extends State<TextNavItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 60),
      child: Center(
        child: Card(
          // 这里card没有用，暂时用来做InkWell的容器
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          child: InkWell(
            onTap: widget.func,
            hoverColor: Colors.transparent,
            onHover: (value) => {setState(() {
              isHovered = value;
            })},
            child: Text(
              widget.title,
              style:
                  isHovered || widget.isActived
                      ? widget.style?.copyWith(color: AppColors.active)
                      : widget.style,
            ),
          ),
        ),
      ),
    );
  }
}
