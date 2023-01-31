import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../res/app_images.dart';
import '../res/app_routes.dart';
import '../res/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimeout()=>Timer(const Duration(seconds: 1), handleTimeout);

  void handleTimeout()=>changeScreen();

  Future<void> changeScreen() async {
    Navigator.pushReplacementNamed(context, AppRoutes.ingredientsScreen);
    //Show status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.logo,
              height: 100,
              fit: BoxFit.cover),
            const SizedBox(height: 25),
            Text(AppStrings.appName,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.secondary))
          ],
        ),
      )
    );
  }
}
