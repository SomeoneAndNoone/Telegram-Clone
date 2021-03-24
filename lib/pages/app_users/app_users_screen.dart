import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/bloc/app_users_bloc/app_users_bloc.dart';
import 'package:telegram_clone/bloc/app_users_bloc/app_users_events.dart';
import 'package:telegram_clone/bloc/app_users_bloc/app_users_states.dart';
import 'package:telegram_clone/common/common_colors.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/pages/app_users/user_item.dart';
import 'package:telegram_clone/models/user_dto.dart';

class AppUsersChatScreen extends StatefulWidget {
  @override
  _AppUsersChatScreenState createState() => _AppUsersChatScreenState();
}

class _AppUsersChatScreenState extends State<AppUsersChatScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String email = Provider.of<ApplicationState>(context).activeUser.email;
    BlocProvider.of<AppUsersBloc>(context).add(AppUsersGetUsersEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUsersBloc, AppUsersStates>(builder: (context, state) {
      if (state is AppUsersReceivedState) {
        return _listUsers(state.appUsers);
      } else if (state is AppUsersLoadingState) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(primaryLight),
          ),
        );
      } else if (state is AppUsersErrorState) {
        return Center(
          child: Text(
            state.error,
            style: TextStyle(color: Colors.red),
          ),
        );
      }
      return SizedBox.shrink();
    });
  }

  Widget _listUsers(List<UserDto> users) {
    return users.isNotEmpty
        ? Container(
            child: Column(
              children: users
                  .map<UserItem>(
                    (chat) => UserItem(
                      userDto: chat,
                    ),
                  )
                  .toList(),
            ),
          )
        : Center(
            child: Text('no users'),
          );
  }
}
