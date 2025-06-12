import 'package:flutter/material.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart';

class ChatScreen extends StatefulWidget {

  final ChatViewmodel viewmodel;

  const ChatScreen({super.key, required this.viewmodel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
    );
  }

  Widget _buildInWide(BuildContext context){
    // 
    return Placeholder();
  }

  Widget _buildOutWide(BuildContext context){
    return Placeholder();
  }

}
