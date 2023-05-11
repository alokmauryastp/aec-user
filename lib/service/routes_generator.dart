import 'package:aec_medical/pages/dashboard/AcceptPage.dart';
import 'package:aec_medical/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

import 'routes.dart' as routes;

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (context) => SplashPage());
        break;
      case routes.ChatScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => AcceptPage());
        break;
      case routes.DashboardScreenRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => SplashPage());
        break;
    }
  }
}
