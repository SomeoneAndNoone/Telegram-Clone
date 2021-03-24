import 'package:flutter/material.dart';
import 'package:telegram_clone/models/chat_dto.dart';

import 'chat_item.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // todo implement chat screen to get active chats
  List<ChatDto> chats = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: chats
            .map<ChatItem>(
              (chat) => ChatItem(
                chatDto: chat,
              ),
            )
            .toList(),
      ),
    );
  }
}
