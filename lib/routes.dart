import 'package:flutter/cupertino.dart';
import 'package:telegram_clone/pages/authentication/splash_screen/splash_screen.dart';
import 'package:telegram_clone/pages/home/home_page.dart';

class TelegramRoutes {
  static const home = '/home';
  static const splash = '/splash';
}

final routes = {
  '/splash': (dynamic _) => SplashScreen(),
  '/home': (dynamic _) => HomePage(),
};

PageRoute getRoute(String route) {
  return CupertinoPageRoute<dynamic>(
    builder: routes[route],
  );
}
