import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/models/user_dto.dart';

class ActiveUserDto extends UserDto {
  ActiveUserDto({
    @required userId,
    @required userName,
    @required this.email,
    @required picture,
    @required joinedAt,
    @required this.chatIds,
    @required this.unReadMessageIds,
  }) : super(userId: userId, joinedAt: joinedAt, userName: userName, picture: picture);

  final List<dynamic> chatIds;
  final String email;
  final List<dynamic> unReadMessageIds;
}
