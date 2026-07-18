import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/app_regex.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/phone_text_form_feild.dart';
import 'sign_up_alert_dialog.dart';
import '../../logic/sighn_up_cubit.dart';

Widget signUpTextFormField({required SignUpCubit cubit, required BuildContext context,}
){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24.w),
    child: Column(
      children: [
        AppTextFormField(
          controller: cubit.nameController,
          hintText: 'Name..',
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },),
        verticalSpace(16),
        appPhoneTextField(controller: cubit.phoneController, onPhoneChanged: (completeNumber) {
          cubit.fullPhoneNumber = completeNumber;
        }),
        verticalSpace(16),
        AppTextFormField(
          controller: cubit.yearsOfExperienceController,
          keyboardtybe: TextInputType.number,
          hintText: 'Years of experience...',
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Years of experience';
            }
            return null;
          },
        ),
        verticalSpace(16),
        AppTextFormField(
          controller:cubit.experienceLevelController,
          readOnly: true,
          hintText: 'Choose experience Level',
          hintStyle: AppTextStyles.font14BlackMedium,
          suffixIcon: GestureDetector(
            child: Icon(Icons.keyboard_arrow_down,size: 32.sp,),
          onTap: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return signUpAlertDialog(context: context, textList: cubit.experienceLevelList, cubit: cubit);

                  });
          },
          ),
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please Choose your experience Level';
            }
            return null;
          },),
        verticalSpace(16),
        AppTextFormField(
          controller: cubit.addressController,
          hintText: 'Address...',
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Address';
            }
            return null;
          },),
        verticalSpace(16),
        AppTextFormField(
          controller: cubit.passwordController,
          hintText: 'Password...',
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a valid Password';
            }else if(!AppRegex.isPasswordValid(value)){
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