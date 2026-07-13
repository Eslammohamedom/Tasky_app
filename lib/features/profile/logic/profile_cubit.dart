import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/secured_storage_helper.dart';
import '../../../core/helpers/sharedprefrences_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
import '../model/profile_error_model.dart';
import '../model/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);


ProfileModel profileModel = ProfileModel();
ProfileFailModel profileFailModel = ProfileFailModel();
  Future<String?>  accessToken = SecureStorageHelper.getData(key: SecureStorageKeys.accessToken);


  Future<void> getProfileData({required BuildContext context}) async {
    emit(ProfileLoading());
    await DioHelper.getData(url: ApiConstants.profileUrl,token:await accessToken).then((value) async{
      if (value.statusCode == 200){
        profileModel = ProfileModel.fromJson(value.data);
        debugPrint("${profileModel.displayName.toString().toUpperCase()} ==++ SUCCESS");
     emit(ProfileSuccess());
      }
    }).catchError((e)async{
      emit(ProfileError());
      debugPrint("${e.toString()} ==++ ERROR");
      if (e.response != null && e.response?.data != null) {
        profileFailModel = ProfileFailModel.fromJson(e.response?.data);
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: profileFailModel.message.toString().toUpperCase(),
          ),
        );
        debugPrint('Error in  PROFILE Cubit ${e.toString()}');
      }
    });
  }

  Future<void>copyPhoneNumber() async {
    await Clipboard.setData(
        ClipboardData(text: profileModel.username.toString()));
    emit(ProfileCopyPhoneNumber());
  }


}
