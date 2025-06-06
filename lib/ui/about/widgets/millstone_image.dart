import 'package:flutter/material.dart';

class MillstoneImage extends StatelessWidget {
  final String imageUrl;
  const MillstoneImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50),
      child: Center(child: Image.asset(imageUrl)),
    );
  }
}
