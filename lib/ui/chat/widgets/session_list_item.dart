import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;



class SessionListItem extends StatelessWidget{

  final bool isActivated;
  final VoidCallback onTap;
  final Session session;

  const SessionListItem({super.key, required this.isActivated, required this.onTap, required this.session});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:      Padding(
          padding: EdgeInsets.only(bottom: 10),
           child: Text(
          session.title,
          style:
              isActivated
                  ? TextStyle(color: Colors.white)
                  : TextStyle(color: AppColors.active),
        )),
    );
  }
  
}