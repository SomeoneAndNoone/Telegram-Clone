import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/models/active_user_dto.dart';

abstract class AuthenticationStates extends Equatable {
  const AuthenticationStates();

  @override
  List<Object> get props => [];
}

class AuthenticationUninitializedState extends AuthenticationStates {}

class AuthenticationLoggedOutState extends AuthenticationStates {}

class AuthenticationShouldRegisterState extends AuthenticationStates {
  const AuthenticationShouldRegisterState({this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class AuthenticationLoggedInState extends AuthenticationStates {
  const AuthenticationLoggedInState({@required this.activeUser});

  final ActiveUserDto activeUser;

  @override
  List<Object> get props => [activeUser];
}

class AuthenticationShouldLoginState extends AuthenticationStates {
  const AuthenticationShouldLoginState({@required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class AuthenticationErrorSate extends AuthenticationStates {
  const AuthenticationErrorSate({this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return '$runtimeType:error:$error';
  }
}

class AuthenticationOnProgressState extends AuthenticationStates {}
