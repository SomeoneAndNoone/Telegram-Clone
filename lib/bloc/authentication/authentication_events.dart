import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthenticationEvents extends Equatable {
  const AuthenticationEvents();

  @override
  List<Object> get props => [];
}

class AuthenticationLoginEvent extends AuthenticationEvents {
  const AuthenticationLoginEvent({
    @required this.email,
    @required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class UninitializeAuthenticationEvent extends AuthenticationEvents {}

class AuthenticationLogoutEvent extends AuthenticationEvents {}

class AuthenticationVerifyEmailEvent extends AuthenticationEvents {
  const AuthenticationVerifyEmailEvent({this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class AuthenticationRegisterEvent extends AuthenticationEvents {
  const AuthenticationRegisterEvent({
    @required this.email,
    @required this.password,
    @required this.confirmPassword,
    @required this.picture,
    @required this.username,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final String picture;
  final String username;

  @override
  List<Object> get props => [email, password, picture, username];
}
