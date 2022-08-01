import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dana_chat/widgets/avatar.dart';
import 'package:dana_chat/models/message_model.dart';
import 'package:dana_chat/widgets/icon_buttons.dart';

class ChatBTNsPage extends StatefulWidget {
  const ChatBTNsPage({Key? key}) : super(key: key);

  @override
  State<ChatBTNsPage> createState() => _ChatBTNsPageState();
}

class _ChatBTNsPageState extends State<ChatBTNsPage> {
  final sendCtrl = TextEditingController();

  _buildMessage(MessageModel message, bool isMe) {
    return Container(
      margin: isMe
          ? const EdgeInsets.only(top: 8, bottom: 8, left: 80)
          : const EdgeInsets.only(top: 8, bottom: 8, right: 80),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
            : const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
        color: isMe ? Colors.green[100] : Colors.blue[100],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.time,
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          Text(
            message.text,
            style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600),
            textAlign: isMe ? TextAlign.right : TextAlign.left,
          ),
        ],
      ),
    );
  }

  _buildButtonsComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple[300],
              side: const BorderSide(
                width: 2,
                color: Color(0XF3E5F5FF),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text("כפתור 3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple[300],
              side: const BorderSide(
                width: 2,
                color: Color(0XF3E5F5FF),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text("כפתור 2", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple[300],
              side: const BorderSide(
                width: 2,
                color: Color(0XF3E5F5FF),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
            child: Text("כפתור 1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
          ),
        ],
      ),
    );
  }

  _sendMessage(String text) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat.jm().format(now);
    setState(() {
      messages.insert(
          0,
          MessageModel(
              sender: currentUser,
              time: DateFormat.jm().format(now),
              text: text,
              unread: true));
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
            _buildButtonsComposer(),
          ],
        ),
      ),
    );
  }
}
