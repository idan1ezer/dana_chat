import 'package:dana_chat/models/user_model.dart';
import 'package:flutter/material.dart';

@immutable
class MessageModel {
  const MessageModel({
    required this.sender,
    required this.text,
    //required this.messageDate,
    required this.time,
    required this.unread
  });
  final UserModel sender;
  final String text;
  //final DateTime messageDate;
  final String time;
  final bool unread;
}


// JUST FOR UI FIRST TRYOUT
//
//
//
// JUST FOR UI FIRST TRYOUT




// YOU - current user
final UserModel currentUser = UserModel(
  id: "0",
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
);

// USERS
final UserModel julia = UserModel(
  id: "1",
  name: 'Julia',
  imageUrl: 'https://unsplash.com/photos/mEZ3PoFGs_k/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHx8fDE2NTgyOTQzMTQ&force=true&w=640',
);
final UserModel james = UserModel(
  id: "2",
  name: 'James',
  imageUrl: 'https://unsplash.com/photos/5OyGRn_r9Y4/download?ixid=MnwxMjA3fDB8MXxzZWFyY2h8Nnx8cHJvZmlsZXxlbnwwfHx8fDE2NTgyOTQzMTQ&force=true&w=640',
);
final UserModel dana = UserModel(
  id: "3",
  name: 'Dana',
  imageUrl: 'https://unsplash.com/photos/rDEOVtE7vOs/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjU4MzE0MjQx&force=true&w=640',
);

List<MessageModel> messages = [
  MessageModel(
    sender: dana,
    time: '4:31 PM',
    text: 'כן, נראה תקין',
    unread: true,
  ),
  MessageModel(
    sender: currentUser,
    time: '4:30 PM',
    text: 'מצטערת לשמוע, האם בדקת את רמות הסוכר?',
    unread: false,
  ),
  MessageModel(
    sender: dana,
    time: '4:30 PM',
    text: 'היי דנה, אני מרגיש קצת חלש',
    unread: false,
  ),
];
