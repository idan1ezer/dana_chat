import 'package:flutter/material.dart';
import 'package:dana_chat/models/message_model.dart';

class ChatScreen extends StatelessWidget {
  static Route route(MessageModel message) => MaterialPageRoute(
    builder: (context) => ChatScreen(
      messageModel: message,
    ),
  );

  const ChatScreen({Key? key, required MessageModel messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}



// NEED TO DELETE
