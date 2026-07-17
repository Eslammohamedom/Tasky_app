import 'package:flutter/material.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/routing/routs.dart';
import 'package:taski/core/theming/colors.dart';

import '../../core/helpers/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        isLoggedInUser?context.pushReplacementNamed(Routes.homeScreen):context.pushReplacementNamed(Routes.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsManager.mainBlue,
      body: Center(
        child: Image.asset("assets/images/android11_splash.png"),
      ),
    );
  }
}
