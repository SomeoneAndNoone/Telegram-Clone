import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/date_util.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/common/widgets/message_count_tag.dart';
import 'package:telegram_clone/models/chat_dto.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key key, @required this.chatDto});

  final ChatDto chatDto;

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<ApplicationState>(context).userId;
    String _chatPicture = chatDto.getFriendPicture(userId);
    String _chatName = chatDto.getFriendName(userId);
    int _unreadMessageCount = chatDto.activeUserUnreadMessageCount(userId);

    return InkWell(
      onTap: () {
        // TODO goto MessageScreen
        // UserDto activeUser = ;// todo;
        // Navigator.push<dynamic>(
        //   context,
        //   MaterialPageRoute<dynamic>(
        //     builder: (context) {
        //       return MessageScreen(chatDto: chatDto);
        //     },
        //   ),
        // );
      },
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.only(left: AppSizes.padding10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Image.asset(
                _chatPicture,
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.white,
              radius: 24,
            ),
            SizedBox(width: AppSizes.padding10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // chat name
                    Text(
                      _chatName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: AppSizes.height5),
                    // last sent message
                    Flexible(
                      child: Text(
                        '${chatDto.lastMessageSent}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: AppSizes.text12,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.5)),
              ),
              padding: EdgeInsets.only(right: AppSizes.padding10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // message date
                  Text(
                    getMessageDate(chatDto.lastMessageDate),
                    style: TextStyle(
                      fontSize: AppSizes.text12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  SizedBox(height: AppSizes.height5),
                  // message tag
                  MessageCountTag(_unreadMessageCount ?? 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
