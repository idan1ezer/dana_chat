import 'package:dana_chat/models/message_model.dart';
import 'package:dana_chat/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dana_chat/widgets/icon_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final languages = ["עברית", "English", "عربي"];
  String? value;
  final passwordCtrl = TextEditingController();

  int selectedLanguage = -1;
  bool isVisiblePassword = false;
  bool isVisibleLanguage = false;
  bool isVisibleFeedback = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        centerTitle: true,
        title: const Text(
          "הגדרות",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.purple[100],
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: ListTile(
                title: Text(currentUser.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
                trailing: Avatar.small(
                  url:
                      "https://s3.eu-west-3.amazonaws.com/dealna/images/Virtual-Assist5-20201231125231.jpg",
                  onTap: () {},
                ),
                leading: Icon(Icons.edit),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.purple[50],
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  ListTile(
                    trailing: Icon(
                      Icons.lock,
                      color: Colors.purple,
                    ),
                    title: Text("שינוי סיסמא",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right),
                    leading: Icon(Icons.keyboard_arrow_down),
                    onTap: () {
                      setState(() {
                        isVisiblePassword = !isVisiblePassword;
                        isVisibleLanguage = false;
                        isVisibleFeedback = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: isVisiblePassword,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple),
                            onPressed: () {
                              // changePassword(passwordCtrl.text);
                            },
                            child: const Text(
                              "שנה",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: passwordCtrl,
                              textAlign: TextAlign.right,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "הקלד סיסמא חדשה",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildDivider(),
                  ListTile(
                    trailing: Icon(
                      Icons.g_translate,
                      color: Colors.purple,
                    ),
                    title: Text("שפה",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right),
                    leading: Icon(Icons.keyboard_arrow_down),
                    onTap: () {
                      setState(() {
                        isVisiblePassword = false;
                        isVisibleLanguage = !isVisibleLanguage;
                        isVisibleFeedback = false;
                      });
                    },
                  ),
                  Visibility(
                    visible: isVisibleLanguage,
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        RadioListTile<int>(
                            value: 0,
                            groupValue: selectedLanguage,
                            title: Text(
                              languages[0],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) =>
                                setState(() => selectedLanguage = 0)),
                        RadioListTile<int>(
                            value: 1,
                            groupValue: selectedLanguage,
                            title: Text(
                              languages[1],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) =>
                                setState(() => selectedLanguage = 1)),
                        RadioListTile<int>(
                            value: 2,
                            groupValue: selectedLanguage,
                            title: Text(
                              languages[2],
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.end,
                            ),
                            controlAffinity: ListTileControlAffinity.trailing,
                            onChanged: (value) =>
                                setState(() => selectedLanguage = 2))
                      ],
                    ),
                  ),
                  _buildDivider(),
                  ListTile(
                    trailing: Icon(
                      Icons.feedback,
                      color: Colors.purple,
                    ),
                    title: Text("שליחת משוב",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right),
                    leading: Icon(Icons.keyboard_arrow_down),
                    onTap: () {
                      setState(() {
                        isVisiblePassword = false;
                        isVisibleLanguage = false;
                        isVisibleFeedback = !isVisibleFeedback;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
  }

  // Future<void> changePassword(String password) async {
  //   // need to change pw

  // //  final user = FirebaseAuth.instance.currentUser;
  //   //final userCredential =
  //       //await FirebaseAuth.instance.signInWithCredential(credential);
  //   //final user = userCredential.user;
  //   await user?.updatePassword(password);

  // }
}

class Item {
  const Item({
    Key? key,
    required this.title,
    required this.icon,
    required this.widget,
  });

  final String title;
  final Icon icon;
  final Widget widget;
}
