import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/common/circle_img.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;

class UserPanel extends StatelessWidget{

  final String avatarUrl;
  final String nickname;
  final IconData operationIcon;
  final VoidCallback operation;
  final Map<String,String>? headers;

  const UserPanel({super.key, required this.avatarUrl, required this.nickname, required this.operationIcon, required this.operation, required this.headers});

  @override
  Widget build(BuildContext context) {
    
    return      Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child:Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleNetImg(imgUrl: avatarUrl, imgSize: Size(35, 35),headers: headers,),
        Text(
                      nickname,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
        IconButton(onPressed: operation, icon: Icon(operationIcon,size: 30,))
      ],
    ));

  }

  

}