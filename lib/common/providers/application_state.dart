import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/models/active_user_dto.dart';

class ApplicationState with ChangeNotifier {
  ApplicationState(this._activeUser);

  ActiveUserDto _activeUser;

  ActiveUserDto get activeUser => _activeUser;

  void setActiveUser(ActiveUserDto activeUser) {
    _activeUser = activeUser;
  }

  String get userId => _activeUser.userId ?? null;
}
