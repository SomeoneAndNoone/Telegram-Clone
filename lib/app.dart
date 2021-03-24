// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/common/constants/general_constants.dart';
import 'package:telegram_clone/routes.dart';

import 'common/providers/application_state.dart';
import 'common/providers/theme_notifier.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, child) {
      return MaterialApp(
        routes: routes,
        initialRoute:
            Provider.of<ApplicationState>(context).activeUser == null ? '/splash' : '/home',
        theme: theme.getTheme(),
        title: GeneralConstants.APP_TITLE,
      );
    });
  }
}
