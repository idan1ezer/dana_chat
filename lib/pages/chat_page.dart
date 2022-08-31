import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dana_chat/widgets/avatar.dart';
import 'package:dana_chat/models/message_model.dart';
import 'package:dana_chat/widgets/icon_buttons.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final sendCtrl = TextEditingController();

  _buildMessage(MessageModel message, bool isMe) {
    return Container(
      margin: isMe ? const EdgeInsets.only(top: 8, bottom: 8, left: 80) : const EdgeInsets.only(top: 8, bottom: 8, right: 80),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: isMe ? const BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)) : const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: isMe ? Colors.green[100] : Colors.blue[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.time, style: const TextStyle(color: Colors.blueGrey,fontSize: 12,fontWeight: FontWeight.w600),),
          Text(message.text, style: const TextStyle(color: Colors.blueGrey,fontSize: 16,fontWeight: FontWeight.w600), textAlign: isMe ? TextAlign.right : TextAlign.left,),
        ],
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          //IconBackground(icon: Icons.photo, onTap: (){}),
          Expanded(child: TextField(
            controller: sendCtrl,
            textAlign: TextAlign.right,
            decoration: const InputDecoration.collapsed(hintText: "...הקלד הודעה",),
          )),
          IconBackground(icon: Icons.send, onTap: (){_sendMessage(sendCtrl.text);}),
        ],
      ),
    );
  }

  _sendMessage(String text) {
    DateTime now = DateTime.now();
    //now = DateTime.now();
    //String formattedTime = DateFormat.Hm().format(now);
    setState((){
      messages.insert(0, MessageModel(sender: currentUser,time: DateFormat('HH:mm').format(now),text: text,unread: true));
    });
    sendCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        centerTitle: true,
        title: const Text(
          "דנה",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Avatar.small(
              url:
                  "https://img.myloview.com/stickers/clinic-nurse-icon-flat-isolated-vector-400-264197513.jpg",
              onTap: () {
                // Do nothing
              },
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple[50],
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final MessageModel message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe);
                  },
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
