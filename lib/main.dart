// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/app.dart';
import 'package:telegram_clone/bloc/app_users_bloc/app_users_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_bloc.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/models/active_user_dto.dart';
import 'package:telegram_clone/repository/app_user/firebase_app_users.dart';
import 'package:telegram_clone/repository/authentication/firebase_authentication.dart';

import 'common/constants/shared_prefs_keys.dart';
import 'common/providers/theme_notifier.dart';
import 'data/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ThemeNotifier.IS_LIGHT_MODE =
      await StorageService.readData(SharedPrefsKeys.THEME_MODE_KEY_IS_LIGHT_MODE) ?? true;

  String userId = await StorageService.readData(SharedPrefsKeys.USER_ID_KEY) as String;

  ActiveUserDto activeUserDto;
  if (userId != null) {
    debugPrint('Active user being initialized');
    activeUserDto = ActiveUserDto(
      userId: await StorageService.readData(SharedPrefsKeys.USER_ID_KEY) as String,
      userName: await StorageService.readData(SharedPrefsKeys.USERNAME_KEY) as String,
      email: await StorageService.readData(SharedPrefsKeys.USER_EMAIL_KEY) as String,
      picture: await StorageService.readData(SharedPrefsKeys.USER_PICTURE_KEY) as String,
      joinedAt: await StorageService.readData(SharedPrefsKeys.JOINED_AT_KEY) as int,
      chatIds: [],
      unReadMessageIds: [],
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (BuildContext context) => ThemeNotifier()),
        ChangeNotifierProvider<ApplicationState>(
            create: (BuildContext context) => ApplicationState(activeUserDto)),
        BlocProvider<AuthenticationBloc>(
            create: (BuildContext context) => AuthenticationBloc(FirebaseAuthentication())),
        BlocProvider<AppUsersBloc>(
            create: (BuildContext context) => AppUsersBloc(FirebaseAppUsers())),
      ],
      child: App(),
    ),
  );
}
