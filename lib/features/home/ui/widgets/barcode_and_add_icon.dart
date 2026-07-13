import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/routing/routs.dart';
import 'package:taski/core/theming/colors.dart';
import '../../logic/home_cubit.dart';

Widget barcodeAndAddIcons(BuildContext context,HomeCubit cubit){
  return  SizedBox(
    height: 120.h,
    child: Row(
      children: [
        Spacer(),
        Column(
          children: [
            GestureDetector(
              onTap: (){
                context.pushNamed(Routes.qrScannerScreen);
              },
              child: CircleAvatar(
                backgroundColor: AppColorsManager.lighterGrey,
                radius: 24.r,
                child: Icon(Icons.qr_code,size: 18.sp,color: AppColorsManager.mainBlue,),

              ),
            ),
            verticalSpace(8),
            GestureDetector(
              onTap: ()async{
               await context.pushNamed(Routes.addNewTaskScreen);
               cubit.clearTasksListAndGetTasksData(context);
              },
              child: CircleAvatar(
                backgroundColor: AppColorsManager.mainBlue,
                radius: 32.r,
                child: Icon(Icons.add,size: 24.sp,color: Colors.white,),

              ),
            ),
          ]
        )
      ],
    ),
  ) ;
}