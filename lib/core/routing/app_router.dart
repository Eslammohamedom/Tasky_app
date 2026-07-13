import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/core/routing/routs.dart';
import '../../features/add_new_task/ui/add_new_task_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/home/ui/widgets/qr_reader/qr_reader_screen.dart';
import '../../features/login/ui/login_screen.dart';
import '../../features/onBoarding/ui/onboarding_screen.dart';
import '../../features/add_new_task/logic/add_task_cubit.dart';

import '../../features/profile/ui/profile_screen.dart';
import '../../features/signup/ui/signup_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/task_details/ui/task_details_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),);
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),);
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),);
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),);
      case Routes.taskDetailsScreen:
        final String taskId = settings.arguments as String? ?? "";
        return MaterialPageRoute(
          builder: (_) => TaskDetailsScreen(id: taskId,),);
      case Routes.addNewTaskScreen:
        return MaterialPageRoute(
          builder: (_) => AddNewTaskScreen(),);
        case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),);
      case Routes.qrScannerScreen:
        return MaterialPageRoute(
          builder: (_) => QrScannerScreen(),);
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),);

      default:
        return null;
    }
  }

}