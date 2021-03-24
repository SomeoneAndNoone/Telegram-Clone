import 'package:equatable/equatable.dart';
import 'package:telegram_clone/models/chat_dto.dart';
import 'package:telegram_clone/models/user_dto.dart';

abstract class AppUsersStates extends Equatable {
  const AppUsersStates();

  @override
  List<Object> get props => [];
}

class AppUsersUninitializedState extends AppUsersStates {}

class AppUsersReceivedState extends AppUsersStates {
  const AppUsersReceivedState({this.appUsers});

  final List<UserDto> appUsers;

  @override
  List<Object> get props => [appUsers];
}

class AppUsersLoadingState extends AppUsersStates {}

class AppUsersErrorState extends AppUsersStates {
  const AppUsersErrorState({this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
