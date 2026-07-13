
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/app_regex.dart';
import 'package:taski/core/theming/colors.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/phone_text_form_feild.dart';
import '../../logic/login_cubit.dart';
class LoginTextFormFields extends StatelessWidget {
 final  LoginCubit cubit;
  const LoginTextFormFields(
      {
   required this.cubit,
    super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 24.w,right:24.w, bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Login",style: AppTextStyles.font24BlackBold,),
          verticalSpace(24),
          appPhoneTextField(controller: cubit.phoneController,),
          verticalSpace(24),
          AppTextFormField(
            maxLines: 1,
            obsecureText: cubit.passwordVisibility,
            controller: cubit.passwordController,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
            hintText: 'password',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a your password';
              }
              else if(!AppRegex.isPasswordValid(value)){
                return 'Please enter a complex Password';
              }
              return null;
            },
            suffixIcon: InkWell(
                onTap: (){
                  cubit.changePasswordVisibility();
                },
                child: Icon(cubit.passwordVisibility ?
                Icons.visibility :
                Icons.visibility_off,
                  color: cubit.passwordVisibility?AppColorsManager.grey:AppColorsManager.mainBlue,
                  size: 24.sp,))


          )
        ],
      ),
    );
  }
}
