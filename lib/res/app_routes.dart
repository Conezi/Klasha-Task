import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/Ingredients_screen.dart';
import '../ui/splash_screen.dart';



class AppRoutes {
  ///Route names used through out the app will be specified as static constants here in this format
  static const String splashScreen = 'splashScreen';
  static const String ingredientsScreen = 'ingredientsScreen';

  static Map<String, Widget Function(BuildContext)> routes = {
    ///Named routes to be added here in this format
    splashScreen: (context) => const SplashScreen(),
    ingredientsScreen: (context) => const IngredientsScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add your screen here as well as the transition you want
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case ingredientsScreen:
        return MaterialPageRoute(builder: (context) => const IngredientsScreen());
      //Default Route is error route
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name!));
    }
  }

  static Widget errorView(String name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}
