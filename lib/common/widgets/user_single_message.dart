import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/common/providers/theme_notifier.dart';
import 'package:telegram_clone/models/message_dto.dart';

import '../app_sizes.dart';

class UserSingleMessage extends StatelessWidget {
  const UserSingleMessage({
    Key key,
    @required this.messageDto,
  });

  final MessageDto messageDto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSizes.padding5, right: AppSizes.padding10),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
            child: Material(
              color: Provider.of<ThemeNotifier>(context).activeUserMessageColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.padding10,
                  vertical: AppSizes.padding5,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.padding5),
                    Flexible(
                      child: Text(
                        messageDto.message,
                        maxLines: 100,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(height: AppSizes.padding5),
                    Text('messageId: ${messageDto.messageId}'),
                    Text('ownerId: ${messageDto.ownerId}')
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
