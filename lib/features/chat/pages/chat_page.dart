import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FilledButton.icon(
        label: const Text("Chat with Expert"),
        onPressed: () {},
        icon: Icon(MdiIcons.chat),
      ),
    );
  }
}
