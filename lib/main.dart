import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/routing/app_router.dart';
import 'package:taski/taski_app.dart';
import 'core/helpers/bloc_observer.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/extentions.dart';
import 'core/helpers/secured_storage_helper.dart';
import 'core/networking/dio_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SecureStorageHelper.init();
  await DioHelper.init();
  await checkIfLoggedInUser();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  runApp(TaskiApp(appRouter: AppRouter()));
}
Future<void> checkIfLoggedInUser() async {
  String? userToken =
  await SecureStorageHelper.getData(key:SecureStorageKeys.accessToken);
  if (!userToken.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}