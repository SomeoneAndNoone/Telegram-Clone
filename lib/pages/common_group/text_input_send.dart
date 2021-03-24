import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_clone/bloc/message_bloc/message_bloc.dart';
import 'package:telegram_clone/bloc/message_bloc/message_event.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/common_colors.dart';

class TextInputSend extends StatefulWidget {
  const TextInputSend({@required this.action});

  final Function(String message) action;

  @override
  _TextInputSendState createState() => _TextInputSendState();
}

class _TextInputSendState extends State<TextInputSend> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.only(left: AppSizes.padding10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                controller: _controller,
                cursorWidth: 3,
                cursorColor: primaryLight,
                showCursor: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Message',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  counter: Offstage(),
                ),
                maxLines: null,
                // maxLength: 1000,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: primaryLight,
              ),
              onPressed: () {
                String message = _controller.text;
                widget.action(message);
                _controller.text = '';
              },
            ),
          ],
        ),
      ),
    );
  }
}
