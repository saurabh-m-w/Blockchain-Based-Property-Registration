import 'package:flutter/material.dart';
import 'package:land_registration/screens/land_inspector_dashboard.dart';
import 'package:land_registration/screens/user_dashboard.dart';
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
            builder: (_) => const home_page(),
            settings: const RouteSettings(name: '/'));
      case '/login':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => CheckPrivateKey(
              val: args,
            ),
            settings: const RouteSettings(name: '/login'),
          );
        }
        return _errorRoute();
      case '/user':
        return MaterialPageRoute(
          builder: (_) => const UserDashBoard(),
          settings: const RouteSettings(name: '/user'),
        );
      case '/registeruser':
        return MaterialPageRoute(
          builder: (_) => const RegisterUser(),
          settings: const RouteSettings(name: '/registeruser'),
        );
      case '/contractowner':
        return MaterialPageRoute(
          builder: (_) => const AddLandInspector(),
          settings: const RouteSettings(name: '/contractowner'),
        );
      case '/landinspector':
        return MaterialPageRoute(
          builder: (_) => const LandInspector(),
          settings: const RouteSettings(name: '/landinspector'),
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
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
