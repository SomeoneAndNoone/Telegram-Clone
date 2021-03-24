import 'package:flutter/material.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/date_util.dart';
import 'package:telegram_clone/models/user_dto.dart';
import 'package:telegram_clone/pages/message_screen/message_screen.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key key, @required this.userDto});

  final UserDto userDto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => MessageScreen(
              friendUser: userDto,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  userDto.picture,
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.white,
              radius: 24,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(width: AppSizes.height05, color: Theme.of(context).dividerColor),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: AppSizes.padding10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: AppSizes.height15),
                      // username, join time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userDto.userName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            getTimeFromDate(userDto.joinedAt),
                            style: TextStyle(
                              fontSize: AppSizes.text12,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.height5),
                      // user id, join date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'User id: ${userDto.userId}',
                            style: TextStyle(
                              fontSize: AppSizes.text12,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          Text(
                            '${getDMYFromDate(userDto.joinedAt)}',
                            style: TextStyle(
                              fontSize: AppSizes.text12,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
