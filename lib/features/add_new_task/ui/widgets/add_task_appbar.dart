import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/theming/styles.dart';

Widget addNNewTaskAppBar(BuildContext context){
  return  SizedBox(
    height: 50.h,
    child: Row(
      children: [
        InkWell(
            onTap: (){
              context.pop();
            },
            child: Icon(Icons.arrow_back,size: 24.sp,)),
        horizontalSpace(16),
        Text("Add new task",style: AppTextStyles.font16BlackBold,)

      ],
    ),

  );
}