import 'package:flutter/material.dart';
import 'package:nz_vpn/core/representation/screens/home_screen.dart';
import 'package:nz_vpn/core/representation/screens/list_server_screen.dart';
import 'package:nz_vpn/core/representation/screens/setting_screen.dart';
import 'package:nz_vpn/core/representation/screens/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case ListServerScreen.routeName:
        return MaterialPageRoute(builder: (context) => ListServerScreen());
      case SettingScreen.routeName:
        return MaterialPageRoute(builder: (context) => SettingScreen());
      default:
    }
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Text("No route defined"),
            ));
  }
}
