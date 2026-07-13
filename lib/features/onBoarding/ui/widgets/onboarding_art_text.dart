import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/styles.dart';

Widget onboardingArtAndText(){
  return Column(
    children: [
      Image.asset("assets/images/art.png",
          width: double.infinity,
          height: 482.h,
          fit: BoxFit.cover
      ),
      Text("Task Management &\n To-Do List",style: AppTextStyles.font24BlackBold,textAlign: TextAlign.center,),
      verticalSpace(16),
      Text("This productive tool is designed to help \nyou better manage your task \nproject-wise conveniently!",style: AppTextStyles.font14SecondaryRegular,textAlign: TextAlign.center,),

    ],
  );
}