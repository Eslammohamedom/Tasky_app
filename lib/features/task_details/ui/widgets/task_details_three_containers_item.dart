import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/features/task_details/ui/widgets/task_alert_dialog.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../logic/task_details_cubit.dart';

Widget taskDetailsContainer({
  required TextEditingController controller,
  required bool isDate,
  required TaskDetailsCubit cubit,
  required BuildContext context ,
  required bool isPriority,
}) {
  return Container(
    padding: EdgeInsets.fromLTRB(24.w, 8.h, 8.w, 8.h),
    height: 50.h,
    decoration: BoxDecoration(
      color: AppColorsManager.lightBlue,
      borderRadius: BorderRadius.circular(12),
    ),
    child: isDate == true
        ? Row(
      children: [
        Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "End Date",
                      style: AppTextStyles.font9SecondaryRegular,
                    ),
                    AppTextFormField(
                      inputTextStyle: AppTextStyles.font14BlackRegular,
                      contentPadding: EdgeInsets.all(0),
                      controller: controller,
                      hintText: '   ',
                      validator: (String? p1) {},
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),

                  ],
                ),
              ),
        Spacer(),
        GestureDetector(
          onTap: () {
            cubit.selectDate(context);
          },
          child: Icon(
            Icons.calendar_month_outlined,
            size: 24.sp,
            color: AppColorsManager.mainBlue,
          ),
        ),
        horizontalSpace(14)
      ],
    ): AppTextFormField(
      readOnly: true,
      inputTextStyle: AppTextStyles.font16MainBlueBold,
      contentPadding: EdgeInsets.only(top: 4.h),
      controller: controller,
      hintText: '',
      validator: (String? p1) {},
      suffixIcon:  GestureDetector(
        onTap: (){
        isPriority
        ?showDialog(context: context,
                 builder: (context){
               return taskDetailsAlertDialog(context: context, textList: cubit.priorityList, cubit: cubit,isPriority: isPriority);})
            :showDialog(context: context,
            builder: (context){
              return taskDetailsAlertDialog(context: context, textList: cubit.statusList, cubit: cubit,isPriority: isPriority);});
        },
        child: Icon(Icons.arrow_drop_down_circle_sharp,size: 24.sp,color: AppColorsManager.mainBlue),),
      prefixIcon: isPriority
          ? Icon(
        Icons.flag,
        color: AppColorsManager.mainBlue,
        size: 24.sp,
      )
          : null,

      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
    ),
  );
}