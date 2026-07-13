
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/theming/colors.dart';
import 'package:taski/core/theming/styles.dart';
import 'package:taski/features/task_details/logic/task_details_cubit.dart';
import 'package:taski/features/task_details/ui/widgets/pop_up_menu.dart';

Widget taskDetailsAppPar(TaskDetailsCubit cubit, BuildContext context,TaskDetailsState state){
  return Container(
    height: 48.h,
    margin: EdgeInsets.only(left: 24.w,right: 16.w,top: 16.h,),
    child: Row(
      children: [
        InkWell(
             onTap: (){
             context.pop();
             },
             child: Icon(Icons.arrow_back,color: AppColorsManager.black,size: 24.sp,)),
        horizontalSpace(8),
        Text("Task Details",style: AppTextStyles.font16BlackBold,),

        Spacer(),
     state is UpdateTaskLoading || state is DeleteTaskLoadingState
         ?CupertinoActivityIndicator()
         :  taskDetailsPopUpMenu(cubit,context,cubit.oneTaskModel.sId.toString()),
      ],
    )

  );
}