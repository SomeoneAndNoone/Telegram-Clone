import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_events.dart';
import 'package:telegram_clone/bloc/authentication/authentication_states.dart';
import 'package:telegram_clone/common/exceptions/informative_exception.dart';
import 'package:telegram_clone/models/active_user_dto.dart';
import 'package:telegram_clone/repository/authentication/firebase_authentication.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvents, AuthenticationStates> {
  AuthenticationBloc(this._authentication) : super(AuthenticationUninitializedState());

  final FirebaseAuthentication _authentication;

  @override
  Stream<AuthenticationStates> mapEventToState(AuthenticationEvents event) async* {
    debugPrint('New Event Requested: $event');
    if (event is UninitializeAuthenticationEvent) {
      yield AuthenticationUninitializedState();
      return;
    }

    if (event is AuthenticationVerifyEmailEvent) {
      yield AuthenticationOnProgressState();
      String grammarError = _checkEmailGrammar(event.email);
      if (grammarError != null) {
        yield AuthenticationErrorSate(error: grammarError);
        return;
      }
      dynamic result = await _authentication.verifyEmail(event.email);

      switch (result) {
        case FirebaseAuthUserEmailStateEnum.register:
          yield AuthenticationShouldRegisterState(email: event.email);
          break;
        case FirebaseAuthUserEmailStateEnum.login:
          yield AuthenticationShouldLoginState(email: event.email);
          break;
        case FirebaseAuthUserEmailStateEnum.error:
          AuthenticationErrorSate(error: 'Unexpected error');
      }
    } else if (event is AuthenticationRegisterEvent) {
      yield AuthenticationOnProgressState();
      String localError = _checkRegistreationError(event);
      if (localError != null) {
        yield AuthenticationErrorSate(error: localError);
        return;
      }

      try {
        ActiveUserDto activeUser = await _authentication.registerEmailAndSaveActiveUser(
            event.email, event.password, event.username, event.picture);
        yield AuthenticationLoggedInState(activeUser: activeUser);
      } on InformativeException catch (e) {
        yield AuthenticationErrorSate(error: e.message);
      }
    } else if (event is AuthenticationLoginEvent) {
      yield AuthenticationOnProgressState();
      if (event.password == null || event.password.isEmpty) {
        yield AuthenticationErrorSate(error: 'Passord cannot be empty');
        return;
      }

      try {
        ActiveUserDto activeUserDto =
            await _authentication.loginWithEmailAndPassword(event.email, event.password);
        yield AuthenticationLoggedInState(activeUser: activeUserDto);
        return;
      } on InformativeException catch (e) {
        yield AuthenticationErrorSate(error: e.message);
        return;
      }
    } else if (event is AuthenticationLogoutEvent) {
      try {
        await _authentication.logout();
      } on InformativeException catch (e) {
        throw InformativeException('Unexpected error happened: ${e.message}');
      }
      return;
    }
  }

  String _checkRegistreationError(AuthenticationRegisterEvent e) {
    if (e.email == null || e.email.isEmpty) {
      return 'Email cannot be empty';
    }

    if (e.password == null || e.password.isEmpty) {
      return "Password field cannot be empty";
    }

    if (e.confirmPassword == null || e.confirmPassword.isEmpty) {
      return 'Confirm password field cannot be empty';
    }

    if (e.picture == null || e.picture.isEmpty) {
      return 'Please select picture';
    }

    if (e.username == null || e.username.isEmpty) {
      return 'Username cannot be empty';
    }

    if (e.password != e.confirmPassword) {
      debugPrint('password: ${e.password}, confirmPassword: ${e.confirmPassword}');
      return 'Password and confirm password do not match';
    }
    return null;
  }

  String _checkEmailGrammar(String email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    }

    if (!email.contains('@') || email.startsWith('@') || email.endsWith('@')) {
      return 'Invalid email';
    }

    return null;
  }
}
