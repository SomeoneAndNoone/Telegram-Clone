import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserDto extends Equatable {
  const UserDto({
    @required this.userId,
    @required this.joinedAt,
    @required this.userName,
    @required this.picture,
  });

  final String userId;
  final int joinedAt;
  final String userName;
  final String picture;

  @override
  List<Object> get props => [userId];
}
