import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/bloc/message_bloc/message_bloc.dart';
import 'package:telegram_clone/bloc/message_bloc/message_event.dart';
import 'package:telegram_clone/bloc/message_bloc/message_state.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/common/providers/theme_notifier.dart';
import 'package:telegram_clone/common/widgets/user_single_message.dart';
import 'package:telegram_clone/models/active_user_dto.dart';
import 'package:telegram_clone/models/chat_dto.dart';
import 'package:telegram_clone/models/user_dto.dart';
import 'package:telegram_clone/pages/common_group/text_input_send.dart';
import 'package:telegram_clone/repository/messages/firebase_messages.dart';

import 'message_item.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({@required this.friendUser, this.chatDto});

  final UserDto friendUser;
  final ChatDto chatDto;

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ActiveUserDto _activeUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _activeUser = Provider.of<ApplicationState>(context).activeUser;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(
        FirebaseMessages(),
        _activeUser,
        widget.friendUser,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    widget.friendUser.picture,
                    fit: BoxFit.cover,
                  ),
                ),
                backgroundColor: Colors.white,
                radius: 18,
              ),
              SizedBox(width: AppSizes.padding10),
              Text(widget.friendUser.userName),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Provider.of<ThemeNotifier>(context).isLightMode
                  ? 'assets/background.jpg'
                  : 'assets/background_dark.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ListView.builder(key: new PageStorageKey('myListView'),
              Flexible(
                fit: FlexFit.loose,
                child: BlocBuilder<MessageBloc, MessageStates>(
                  buildWhen: (prevState, curState) {
                    if (curState is MessageSentState ||
                        curState is MessageStatusUpdatedState ||
                        curState is MessageSendingError ||
                        curState is MessageDeletedState) {
                      return false;
                    }
                    return true;
                  },
                  builder: (context, state) {
                    if (state is MessagesLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is MessagesReceivedState) {
                      if (state.messages.isEmpty) {
                        return Center(
                          child: Text('No messages'),
                        );
                      } else {
                        ListView(
                          // physics: NeverScrollableScrollPhysics(),
                          children: state.messages
                              .asMap()
                              .entries
                              .map(
                                (e) => e.value.ownerId != widget.friendUser.userId
                                    ? MessageItem(
                                        key: Key(e.value.messageId),
                                        messageDto: e.value,
                                      )
                                    : UserSingleMessage(messageDto: e.value),
                              )
                              .toList(),
                          reverse: true,
                        );
                      }
                    }

                    if (state is GetMessagesErrorState) {
                      return Center(
                        child: Text(
                          'Error: ${state.error}',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ),
              TextInputSend(action: _sendMessage),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage(String message) {
    BlocProvider.of<MessageBloc>(context).add(SendMessageEvent(message: message));
  }
}
