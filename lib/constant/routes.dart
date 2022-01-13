import 'package:flutter/material.dart';
import 'package:land_registration/screens/LandInspectorDashboard.dart';
import 'package:land_registration/screens/UserDashboard.dart';
import 'package:land_registration/screens/addLandInspector.dart';
import 'package:land_registration/screens/home_page.dart';
import 'package:land_registration/screens/registerUser.dart';
import 'package:land_registration/screens/wallet_connect.dart';

class RoutesName {
  static const String HOME_PAGE = '/';
  static const String LOGIN_PAGE = '/login';
  static const String USER_PAGE = '/userdahsboard';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => home_page(), settings: RouteSettings(name: '/'));
      case '/login':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => CheckPrivateKey(
              val: args,
            ),
            settings: RouteSettings(name: '/login'),
          );
        }
        return _errorRoute();
      case '/user':
        return MaterialPageRoute(
          builder: (_) => UserDashBoard(),
          settings: RouteSettings(name: '/user'),
        );
      case '/registeruser':
        return MaterialPageRoute(
          builder: (_) => RegisterUser(),
          settings: RouteSettings(name: '/registeruser'),
        );
      case '/contractowner':
        return MaterialPageRoute(
          builder: (_) => AddLandInspector(),
          settings: RouteSettings(name: '/contractowner'),
        );
      case '/landinspector':
        return MaterialPageRoute(
          builder: (_) => LandInspector(),
          settings: RouteSettings(name: '/landinspector'),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
