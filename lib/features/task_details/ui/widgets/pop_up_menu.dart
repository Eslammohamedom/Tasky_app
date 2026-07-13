import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../core/helpers/extentions.dart';
import '../../logic/task_details_cubit.dart';



Widget taskDetailsPopUpMenu(TaskDetailsCubit cubit,BuildContext context,String id){

  return PopupMenuButton<String>(
    menuPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
    icon: const Icon(Icons.more_vert, color: AppColorsManager.black),
    elevation: 4,
    offset: const Offset(0, 45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      // side: BorderSide(color: AppColorsManager.lighterGrey, width:0),
    ),
    color: Colors.white,
    onSelected: (String value) async{
      if (value == 'edit'){
        cubit.selectedImage != null
     ? cubit.editTask(context: context, id: id)
     :  cubit.editTaskTexts(context: context, id: id, image: '') ;
      }else if (value == 'delete'){
       await cubit.deleteTask(context: context, id: id);
       context.pop();
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