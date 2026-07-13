import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/widgets/app_text_form_field.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/add_task_cubit.dart';
import 'add_task_dialog.dart';

Widget addTaskPriorityItem({
  required TextEditingController controller,
  // required bool isPriority,
  required String hintText,
  required AddTaskCubit cubit,
  required BuildContext context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Priority", style: AppTextStyles.font12SecondaryRegular),
      verticalSpace(8),
      GestureDetector(
        onTap: (){
          showDialog(
            context: context,
            builder: (context) {
              return addTaskAlertDialog(
                context: context,
                height: 160,
                textList: cubit.priorityList,
                onTap: (index) {
                  cubit.selectPriority(index, context);
                },
              );
            },
          );
        },
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IgnorePointer(
            child: AppTextFormField(
              controller: controller,
              inputTextStyle: AppTextStyles.font16MainBlueBold,
              hintText: "  ",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please Select Priority";
                }
              },
              readOnly: true,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              prefixIcon: Icon(Icons.flag, color: AppColorsManager.mainBlue),
              suffixIcon: Icon(
                Icons.arrow_drop_down_circle_sharp,
                color: AppColorsManager.mainBlue,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget addTaskDateItem({
  required TextEditingController controller,
  required String hintText,
  required BuildContext context,
  required AddTaskCubit cubit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Due date", style: AppTextStyles.font12SecondaryRegular),
      verticalSpace(8),
      AppTextFormField(
        readOnly: true,
        inputTextStyle: AppTextStyles.font16MainBlueBold,
        controller: controller,
        hintText: "  ",
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Select Date";
          }
        },
        suffixIcon: GestureDetector(
          onTap: () {
            cubit.selectDate(context);
          },
          child: Icon(
            Icons.calendar_month_outlined,
            color: AppColorsManager.mainBlue,
          ),
        ),
      ),
    ],
  );
}
