import 'package:dana_chat/models/message_model.dart';
import 'package:dana_chat/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:dana_chat/widgets/icon_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final languages = ["Heberew", "English", "Arabic"];
  String? value;
  final passwordCtrl = TextEditingController();

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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            SizedBox(height: 10,),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.purple[50],
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  ListTile(
                    trailing: Icon(Icons.lock, color: Colors.purple,),
                    title: Text("שינוי סיסמא", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                    leading: Icon(Icons.keyboard_arrow_down),
                    onTap: (){},
                  ),
                  _buildDivider(),
                  ListTile(
                    trailing: Icon(Icons.g_translate, color: Colors.purple,),
                    title: Text("שפה", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                    leading: Icon(Icons.keyboard_arrow_down),
                    onTap: (){},
                  ),
                  _buildDivider(),
                  ListTile(
                    trailing: Icon(Icons.feedback, color: Colors.purple,),
                    title: Text("שליחת משוב", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                    leading: Icon(Icons.keyboard_arrow_down),
                    onTap: (){},
                  ),_buildDivider(),
                  ListTile(
                    trailing: Icon(Icons.logout, color: Colors.purple,),
                    title: Text("התנתקות", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                    onTap: (){},
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


}
