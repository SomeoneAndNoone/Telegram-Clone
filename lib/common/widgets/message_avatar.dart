import 'package:flutter/material.dart';
import 'package:telegram_clone/common/app_sizes.dart';

class MessageAvatar extends StatelessWidget {
  const MessageAvatar({
    @required this.imageAsset,
    this.shouldShowAvatar = false,
  });

  final String imageAsset;
  final bool shouldShowAvatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.padding10),
      child: shouldShowAvatar
          ? CircleAvatar(
              child: Image.asset(
                imageAsset,
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.white,
              radius: 15,
            )
          : SizedBox(width: 30),
    );
  }
}
