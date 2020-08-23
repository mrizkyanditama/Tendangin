import 'package:boilerplate/ui/football/team/news.dart';
import 'package:boilerplate/ui/initial/initial.dart';
import 'package:flutter/material.dart';

import 'ui/splash/splash.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String initial = '/initial';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    initial: (BuildContext context) => InitialPage()
  };
}



