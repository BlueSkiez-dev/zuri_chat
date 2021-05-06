import 'package:flutter/material.dart';
import 'package:zuri_chat/widgets/chat_box.dart';
import 'package:zuri_chat/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(222, 229, 238, 1),
      body: Row(
        children: [
          SideMenu(),
          Expanded(
            child: ChatBox(),
          )
        ],
      ),
    );
  }
}
