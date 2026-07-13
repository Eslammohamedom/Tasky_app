import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/theming/colors.dart';
import 'package:taski/features/profile/logic/profile_cubit.dart';
import '../../../../core/theming/styles.dart';
import '../../model/profile_model.dart';

Widget profileDataItem({required bool isPhone,required ProfileCubit cubit,required String hintText,required String text  }) {
  return Container(
    margin: EdgeInsets.only(top: 16.h),
    height: 68.h,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: AppColorsManager.moreLighterGrey,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: isPhone
        ? Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hintText, style: AppTextStyles.font12BlackMedium),
                  Text(text, style: AppTextStyles.font18BlackBold),
                ],
              ),
              Spacer(),
              InkWell(
                child: Icon(
                  Icons.copy_sharp,
                  color: AppColorsManager.mainBlue,
                  size: 24.sp,
                ),
                onTap: (){
                 cubit.copyPhoneNumber();

                  },
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(hintText, style: AppTextStyles.font12BlackMedium),
              Text(text, style: AppTextStyles.font18BlackBold),
            ],
          ),
  );
}
