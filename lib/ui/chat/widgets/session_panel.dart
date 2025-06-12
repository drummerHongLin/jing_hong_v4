import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jing_hong_v4/data/model/chat/session.dart';

class SessionPanel extends StatelessWidget {
  final double height;
  final double width;
  final ChatModel model;
  final Session session;
  final GlobalKey<AnimatedListState> _listKey ;

  SessionPanel({
    super.key,
    required this.height,
    required this.width,
    required this.model, required this.session,
  }):_listKey= GlobalKey<AnimatedListState>();


  void addItem(int sessionsCount) {
    _listKey.currentState?.insertItem(
      sessionsCount,
      duration: const Duration(seconds: 1),
    );
  }

  
  void clearList() {
    _listKey.currentState?.removeAllItems((context, a) {
      return SizedBox.shrink();
    }, duration: Duration.zero);
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(model.iconUrl, width: 30, height: 30),
                    Icon(Icons.vertical_split_outlined, size: 25),
                  ],
                ),
              ),
              IconButton.outlined(
                onPressed: () {},
                icon: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Icon(Icons.add_circle_outline_outlined, size: 25),
                    Text(
                      "新建会话",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 8,
                  children: [
                    Icon(Icons.access_time_outlined, size: 25),
                    Text(
                      '历史会话',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 41),
                  child: AnimatedList(
                    key: _listKey,
                    itemBuilder: (context,index,a){
                    return SizedBox.shrink();
                  },reverse: true,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
