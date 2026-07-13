import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/routing/routs.dart';
import 'package:taski/features/signup/models/sign_up_fail_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/secured_storage_helper.dart';
import '../../../core/helpers/sharedprefrences_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
import '../models/sign_up_model.dart';

part 'sighn_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController yearsOfExperienceController = TextEditingController();
  final TextEditingController experienceLevelController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  SignUpModel signupModel = SignUpModel();
  SignUpFailModel signupFailModel = SignUpFailModel();

  List<String> experienceLevelList = ["fresh" , "junior" , "midLevel" , "senior"];

void saveExperienceLevel(String txt,BuildContext context){
  experienceLevelController.text = txt;
  debugPrint(nameController.text);
  context.pop();
  emit(SignUpSaveLevelSuccess());
}



  var passwordVisibility = false;
  void changePasswordVisibility(){
    passwordVisibility = !passwordVisibility;
    emit(SignUpChangePasswordVisibility());
  }




  Future<void> userRegister({required BuildContext context}) async {
    emit(SignUpLoading());
    await DioHelper.postData(url: ApiConstants.signUpUrl, data: {
      'phone': phoneController.text.trim(),
      'password': passwordController.text.trim(),
      'displayName': nameController.text.trim(),
      'experienceYears': int.tryParse(yearsOfExperienceController.text) ?? 0,
      'level': experienceLevelController.text.trim(),
      'address': addressController.text.trim(),
    }).then((value) async{
      if (value.statusCode == 201){
        signupModel = SignUpModel.fromJson(value.data);
        debugPrint("${signupModel.displayName.toString().toUpperCase()} ==++ SUCCESS");
        context.pushNamed(Routes.homeScreen);
        await SecureStorageHelper.saveData(key: SecureStorageKeys.accessToken, value: signupModel.accessToken.toString());
        await SecureStorageHelper.saveData(key: SecureStorageKeys.refreshToken, value: signupModel.refreshToken.toString());
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.success(
            message: "تم تسجيل الدخول بنجاح".toUpperCase(),
          ),
        );
         emit(SignUpSuccess());
      }

    }).catchError((e){
      emit(SignUpError());
      print("${e.toString()} ==++ ERROR");
      if (e.response != null && e.response?.data != null) {
        signupFailModel = SignUpFailModel.fromJson(e.response?.data);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: signupFailModel.message.toString().toUpperCase(),
          ),
        );
        print('Error in  REGISTAR Cubit ${e.toString()}');
      }
    });
  }
}
