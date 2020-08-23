import 'dart:async';

import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/ui/football/index.dart';
import 'package:boilerplate/utils/utils/route_util.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Center(child: AppIconWidget(image: Assets.appLogo)),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    print(preferences.getString(Preferences.team_id));

    if (preferences.getString(Preferences.team_id) == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.initial, (Route<dynamic> route) => false);
    } else {
      pushAndRemovePage(context, TeamHomePage( id: preferences.getString(Preferences.team_id)));
    }
  }
}
