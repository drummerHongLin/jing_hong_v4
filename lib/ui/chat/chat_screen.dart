import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20,
        width: 20,
        child: IconButton(
          onPressed: (){context.push("/login");},
          icon: Icon(Icons.login_outlined),
        ),
      ),
    );
  }
}
