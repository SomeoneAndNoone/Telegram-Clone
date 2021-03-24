import 'package:flutter/material.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/models/message_dto.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key key,
    @required this.messageDto,
  });

  // TODO update message statuses so that user
  // TODO will be able to know current message status if necessary

  final MessageDto messageDto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: AppSizes.padding5, left: AppSizes.padding10),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 100),
            child: Material(
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
                    Flexible(
                      child: Text(
                        messageDto.message,
                        maxLines: 100,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    SizedBox(height: AppSizes.padding5),
                    Text('messageId: ${messageDto.messageId}'),
                    Text('ownerId: ${messageDto.ownerId}'),
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
