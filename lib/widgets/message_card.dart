import 'package:dana_chat/models/message_model.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  //const MessageCard({Key? key, required this._messageModel}) : super(key: key);

  final MessageModel _messageModel;
  MessageCard(this._messageModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(_messageModel.text),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

