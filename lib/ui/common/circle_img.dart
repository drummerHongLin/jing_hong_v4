import 'package:flutter/material.dart';

class CircleImg extends StatelessWidget {
  final String imgFilePath;
  final Size imgSize;
  final Color? color;
  final List<BoxShadow>? boxShadow;

  const CircleImg({
    super.key,
    required this.imgFilePath,
    required this.imgSize,
    this.color,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgSize.height,
      width: imgSize.width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        shape: BoxShape.circle,
        color: color,
        image: DecorationImage(image: AssetImage(imgFilePath)),
      ),
    );
  }
}


class CircleNetImg extends StatelessWidget {
  final String imgUrl;
  final Size imgSize;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final Map<String,String>? headers;

  const CircleNetImg({
    super.key,
    required this.imgUrl,
    required this.imgSize,
    this.color,
    this.boxShadow,
    this.headers
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imgSize.height,
      width: imgSize.width,
      decoration: BoxDecoration(
        boxShadow: boxShadow,
        shape: BoxShape.circle,
       border: Border.all(color: Colors.white, width: 2),
        color: color,
        image: DecorationImage(image: NetworkImage(imgUrl,headers: headers),fit: BoxFit.cover),
      ),
    );
  }
}