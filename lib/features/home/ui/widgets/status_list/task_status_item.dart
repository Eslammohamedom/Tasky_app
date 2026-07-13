import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/home/logic/home_cubit.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';

Widget taskStatusItem(HomeCubit cubit,index){
  return GestureDetector(
    onTap: () {
      cubit.setCurrentStatusIndex(index);
      // debugPrint(cubit.allTasksByStatus[cubit.currentStatusIndex].length.toString());
    },
    child: Container(
      margin: EdgeInsets.only(right: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: cubit.currentStatusIndex==index?AppColorsManager.mainBlue: AppColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(
        child: Text(
          cubit.tasksStatus[index],
          textAlign: TextAlign.center,
          style: cubit.currentStatusIndex==index?AppTextStyles.font16WhiteBold:AppTextStyles.font16LightGreyRegular,
        ),
      ),
    ),
  );
}