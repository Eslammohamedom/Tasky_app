
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/theming/styles.dart';

import '../../../../core/helpers/extentions.dart';
import '../../../../core/routing/routs.dart';
import '../../../../core/theming/colors.dart';

Widget onboardingTextButton(BuildContext context ){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 22.w),
    child: TextButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          AppColorsManager.mainBlue,
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical:  14.h,
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size( double.maxFinite,50.h),
        ),
      ),
      onPressed: (){
       context.pushNamed(Routes.loginScreen);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Let’s Start",
            style: AppTextStyles.font19WhiteBold,
          ),
          horizontalSpace(8),
          Icon(Icons.arrow_forward_ios,color: Colors.white,),
        ],
      ),
    ),
  );
}