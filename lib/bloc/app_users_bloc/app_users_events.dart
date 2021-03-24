import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/models/user_dto.dart';

abstract class AppUsersEvents extends Equatable {
  const AppUsersEvents();

  @override
  List<Object> get props => [];
}

class AppUsersGetUsersEvent extends AppUsersEvents {
  const AppUsersGetUsersEvent({@required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class AppUsersDataReceivedEvent extends AppUsersEvents {
  const AppUsersDataReceivedEvent({@required this.users});

  final List<UserDto> users;
}
