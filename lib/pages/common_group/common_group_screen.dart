import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/common/providers/theme_notifier.dart';
import 'package:telegram_clone/pages/common_group/text_input_send.dart';

class CommonGroupScreen extends StatefulWidget {
  @override
  _CommonGroupScreenState createState() => _CommonGroupScreenState();
}

class _CommonGroupScreenState extends State<CommonGroupScreen> {
  String _pageStorageKey = 'chat/chat_screen.dart:pagestorage_key';

  String _userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userId = Provider.of<ApplicationState>(context).userId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: ListView(
              key: PageStorageKey(_pageStorageKey),
              // TODO add common group later
              children: [],
              // physics: NeverScrollableScrollPhysics(),
              // children: fakeMessagesForUserOne
              //     .asMap()
              //     .entries
              //     .map(
              //       (e) => e.value.ownerId != _userId
              //           ? OtherSingleMessage(
              //               key: Key(e.value.messageId),
              //               messageDto: e.value,
              //               shouldShowAvatar: e.key == 0 ||
              //                   e.value.ownerId != fakeMessagesForUserOne[e.key - 1].ownerId,
              //               shouldShowName: e.key == fakeMessagesForUserOne.length - 1 ||
              //                   e.value.ownerId != fakeMessagesForUserOne[e.key + 1].ownerId,
              //             )
              //           : UserSingleMessage(messageDto: e.value),
              //     )
              //     .toList(),
              reverse: true,
            ),
          ),
          TextInputSend(),
        ],
      ),
    );
  }
}
