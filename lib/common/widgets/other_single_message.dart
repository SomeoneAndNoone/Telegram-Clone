import 'package:flutter/material.dart';
import 'package:telegram_clone/common/common_colors.dart';
import 'package:telegram_clone/common/widgets/message_avatar.dart';
import 'package:telegram_clone/models/message_dto.dart';

import '../app_sizes.dart';

class OtherSingleMessage extends StatelessWidget {
  const OtherSingleMessage({
    Key key,
    @required this.messageDto,
    this.shouldShowAvatar = true,
    this.shouldShowName,
  });

  final MessageDto messageDto;
  final bool shouldShowAvatar;
  final bool shouldShowName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: shouldShowAvatar ? AppSizes.padding15 : AppSizes.padding5),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MessageAvatar(
            imageAsset: messageDto.ownerPicture,
            shouldShowAvatar: shouldShowAvatar,
          ),
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
                    if (shouldShowName)
                      Text(
                        messageDto.ownerName,
                        style: TextStyle(
                          color: primaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
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
