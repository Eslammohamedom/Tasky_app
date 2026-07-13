import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/home/logic/home_cubit.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/routing/routs.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../task_details/ui/task_details_screen.dart';
import '../../../models/all_tasks_model.dart';


Widget iconMorePopUpMenu(HomeCubit cubit,BuildContext context,List<Data>data,index){

  return PopupMenuButton<String>(
    menuPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
    icon: const Icon(Icons.more_vert, color: AppColorsManager.black),
    elevation: 4,
    offset: const Offset(0, 45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    color: Colors.white,
    onSelected: (String value) async{
      if (value == 'edit'){
       await context.pushNamed(Routes.taskDetailsScreen,arguments: data[index].sId.toString());
        cubit.clearTasksListAndGetTasksData(context);
      }else if (value == 'delete') {
       cubit.deleteTask(context: context, id: data[index].sId.toString());
      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: 'edit',
        height: 30.h, // Keeps the layout compact
        child: Center(
          child: Text(
              'Edit',
              style: AppTextStyles.font16DarkMedium
          ),
        ),
      ),
      PopupMenuDivider(height: 1),
      PopupMenuItem<String>(
        value: 'delete',
        height: 30.h,
        child: Center(
          child: Text(
            'Delete',
            style: AppTextStyles.font16OrangeMedium,
          ),
        ),
      ),
    ],
  );
}