import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helpers/constants.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routs.dart';
import 'core/theming/colors.dart';
class TaskiApp extends StatelessWidget {
  final AppRouter appRouter;
  const TaskiApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: "TASKY",
        theme: ThemeData(
          primaryColor: AppColorsManager.mainBlue,
          scaffoldBackgroundColor: Colors.white,),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: Routes.splashScreen,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
