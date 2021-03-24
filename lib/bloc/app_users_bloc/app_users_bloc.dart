import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_clone/bloc/app_users_bloc/app_users_events.dart';
import 'package:telegram_clone/bloc/app_users_bloc/app_users_states.dart';
import 'package:telegram_clone/models/user_dto.dart';
import 'package:telegram_clone/repository/app_user/firebase_app_users.dart';

class AppUsersBloc extends Bloc<AppUsersEvents, AppUsersStates> {
  AppUsersBloc(this._firebaseAppUsers) : super(AppUsersUninitializedState());

  final FirebaseAppUsers _firebaseAppUsers;
  StreamSubscription<List<UserDto>> _userStream;

  @override
  Stream<AppUsersStates> mapEventToState(AppUsersEvents event) async* {
    debugPrint('New Event Requested: $event');

    if (event is AppUsersGetUsersEvent) {
      if (event.email == null || event.email.isEmpty) {
        yield AppUsersErrorState(error: 'Unexpected error');
        return;
      }

      if (_userStream == null) {
        yield AppUsersLoadingState();
        _userStream = _firebaseAppUsers.getAppUsersSubscription(event.email).listen((users) {
          add(AppUsersDataReceivedEvent(users: users));
        });
      }
    }

    if (event is AppUsersDataReceivedEvent) {
      yield AppUsersReceivedState(appUsers: event.users);
    }
  }

  @override
  Future<void> close() {
    if (_userStream != null) {
      _userStream.cancel();
    }
    return super.close();
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
