import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/common/providers/theme_notifier.dart';

class MessageCountTag extends StatelessWidget {
  const MessageCountTag(this.messageCount) : assert(messageCount != null);
  final int messageCount;

  @override
  Widget build(BuildContext context) {
    return messageCount != 0
        ? Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Provider.of<ThemeNotifier>(context).tagColor,
            ),
            child: Center(
                child: Text(
              messageCount.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            )),
          )
        : SizedBox(
            width: 22,
            height: 22,
          );
  }
}
