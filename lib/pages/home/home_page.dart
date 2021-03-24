// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/bloc/authentication/authentication_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_events.dart';
import 'package:telegram_clone/bloc/authentication/authentication_states.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/common/widgets/theme_mode_changer.dart';
import 'package:telegram_clone/models/active_user_dto.dart';
import 'package:telegram_clone/pages/app_users/app_users_screen.dart';
import 'package:telegram_clone/pages/chat/chat_screen.dart';
import 'package:telegram_clone/pages/common_group/common_group_screen.dart';

import '../../routes.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  ActiveUserDto _activeUser;

  TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      _dismissKeyboard();
      setState(() {});
      _selectedIndex = _controller.index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activeUser = Provider.of<ApplicationState>(context).activeUser;
  }

  void listenLogoutEvent() {
    BlocProvider.of<AuthenticationBloc>(context).listen((state) {
      if (state is AuthenticationLoggedOutState) {
        Navigator.pushNamedAndRemoveUntil(context, TelegramRoutes.splash, (_) => false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset(
                _activeUser.picture,
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.white,
              radius: 18,
            ),
            SizedBox(width: AppSizes.padding10),
            Text(_activeUser.userName),
          ],
        ),
        actions: [
          ThemeModeChanger(),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutEvent());
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(child: Text('App Users')),
            Tab(child: Text('Chats')),
            Tab(child: Text('Common Group')),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          AppUsersChatScreen(),
          ChatScreen(),
          CommonGroupScreen(),
        ],
      ),
    );
  }

  void _dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
