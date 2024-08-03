import 'package:buyer_app/authentication/login.dart';
import 'package:buyer_app/authentication/register.dart';
import 'package:buyer_app/global/route.dart';
import 'package:buyer_app/home/dashboard_screen.dart';
import 'package:buyer_app/home/home_screen.dart';
import 'package:buyer_app/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
            builder: (_) => const MySplashScreen(),
            settings: const RouteSettings(name: RouteName.splashScreen));
      case RouteName.login:
        return MaterialPageRoute(
            builder: (_) => const LoginScreen(),
            settings: const RouteSettings(name: RouteName.login));
      case RouteName.register:
        return MaterialPageRoute(
            builder: (_) => const RegisterScreen(),
            settings: const RouteSettings(name: RouteName.register));
      case RouteName.dashboard:
        return MaterialPageRoute(
            builder: (_) => DashboardScreen(),
            settings: const RouteSettings(name: RouteName.dashboard));
     case RouteName.home:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
            settings: const RouteSettings(name: RouteName.home));
      default:
        return MaterialPageRoute(
            builder: (_) => const MySplashScreen(),
            settings: const RouteSettings(name: RouteName.splashScreen));
    }
  }
}
