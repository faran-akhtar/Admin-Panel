import 'package:flutter/material.dart';
import '../app.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (_) => const MainScreen(),
        );
      case Routes.driverRegister:
        return MaterialPageRoute(
          builder: (_) => const DriverRegister(),
        );
      case Routes.studentRegister:
        return MaterialPageRoute(
          builder: (_) =>  StudentRegister(),
        );
      case Routes.busesScreen:
        return MaterialPageRoute(
          builder: (_) =>  const BusesScreen(),
        );

      default:
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
