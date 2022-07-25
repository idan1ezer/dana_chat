import 'package:dana_chat/widgets/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dana_chat/pages/pages.dart';
import 'package:dana_chat/widgets/icon_buttons.dart';

class HomeScreen extends StatelessWidget {
  static Route get route => MaterialPageRoute(
    builder: (context) => HomeScreen(),
  );
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(1);
  final ValueNotifier<String> title = ValueNotifier("הודעות");

  final pages = const [SettingsPage(), ChatPage()];
  final pageTitles = const ["הגדרות", "הודעות"];

  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.purple[300],
      //   centerTitle: true,
      //   title: ValueListenableBuilder(
      //     valueListenable: title,
      //     builder: (BuildContext context, String value, _) {
      //       return Text(
      //         value,
      //         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //       );
      //     },
      //   ),
      //   leadingWidth: 54,
      //   leading: Align(
      //     alignment: Alignment.centerRight,
      //     child: ElevatedButton(
      //       onPressed: () {debugPrint("TODO search");},
      //       style: ElevatedButton.styleFrom(primary: Colors.purple[300]),
      //       child: const Icon(
      //           Icons.search
      //       ),
      //     ),
      //     // child: IconBackground(
      //     //   icon: Icons.search,
      //     //   onTap: (){
      //     //     debugPrint("TODO search");
      //     //   },
      //     // ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 24),
      //       child: Hero(
      //         tag: 'hero-profile-picture',
      //         child: Avatar.small(
      //           url: "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
      //           onTap: (){
      //             debugPrint("TODO move to profile page");
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[value];
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);

  final ValueChanged<int> onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 1;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    //final brightness = Theme.of(context).brightness;
    return Card(
      color: Colors.purple[50],
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 8, left: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                index: 0,
                lable: "הגדרות",
                icon: Icons.settings,
                isSelected: (selectedIndex == 0),
                onTap: handleItemSelected,
              ),
              _NavigationBarItem(
                index: 1,
                lable: "הודעות",
                icon: CupertinoIcons.bubble_left_bubble_right_fill,
                isSelected: (selectedIndex == 1),
                onTap: handleItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    Key? key,
    required this.index,
    required this.lable,
    required this.icon,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final String lable;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.purple : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple)
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

