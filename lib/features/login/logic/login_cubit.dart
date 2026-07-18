import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/secured_storage_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
import '../models/login_fail_model.dart';
import '../models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
String? fullPhoneNumber;

LoginModel loginModel = LoginModel();
LoginFailModel loginFailModel = LoginFailModel();

  Future<void> userLogin({required BuildContext context}) async {
    emit(LoginLoading());
    await DioHelper.postData(url: ApiConstants.loginUrl, data: {
      'phone': fullPhoneNumber,
      'password': passwordController.text.trim(),
    }).then((value) async{
      if (value.statusCode == 201){
        loginModel = LoginModel.fromJson(value.data);
        debugPrint("${loginModel.sId.toString().toUpperCase()} ==++ SUCCESS");
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "تم تسجيل الدخول بنجاح".toUpperCase(),
          ),
        );
        await SecureStorageHelper.saveData(key:SecureStorageKeys.accessToken, value: loginModel.accessToken.toString());
        await SecureStorageHelper.saveData(key: SecureStorageKeys.refreshToken, value: loginModel.refreshToken.toString());
        emit(LoginSuccess());
      }

    }).catchError((e){
      emit(LoginFail());
      print("${e.toString()} ==++ ERROR");
      if (e.response != null && e.response?.data != null) {
        loginFailModel = LoginFailModel.fromJson(e.response?.data);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: loginFailModel.message.toString().toUpperCase(),
          ),
        );
        print('Error in  REGISTAR Cubit ${e.toString()}');
      }
    });
  }


  var passwordVisibility = false;
  void changePasswordVisibility(){
    passwordVisibility = !passwordVisibility;
    emit(LoginChangePasswordVisibility());
  }










}
