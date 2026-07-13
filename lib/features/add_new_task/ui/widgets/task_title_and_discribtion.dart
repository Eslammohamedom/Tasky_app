import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/theming/styles.dart';

import '../../../../core/widgets/app_text_form_field.dart';

Widget taskTitleAndDescription({required TextEditingController taskTitleController,required TextEditingController taskDescriptionController} ){
  return Column(
    children: [
      taskTitle(taskTitleController: taskTitleController),
      verticalSpace(16),
      taskDescription(taskDescriptionController: taskDescriptionController),
    ],

  );
}





Widget taskTitle({required TextEditingController taskTitleController}){

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Task title",style: AppTextStyles.font12SecondaryRegular,),
      verticalSpace(8),
      AppTextFormField(
        controller: taskTitleController,
        hintText: 'Enter title here...',
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Address task title';
          }
          return null;
        },),
    ],
  );
}

Widget taskDescription({required TextEditingController taskDescriptionController}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Task Description",style: AppTextStyles.font12SecondaryRegular,),
      verticalSpace(8),
      SizedBox(
        height: 170.h,
        width: double.infinity,
        child: AppTextFormField(
          expands: true,
          maxLines: null,
          minLines: null,
          keyboardtybe: TextInputType.multiline,
          controller: taskDescriptionController,
          constraints: BoxConstraints(maxHeight: 300.h,minHeight: 300.h),
          hintText: 'Enter description here...',
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your task Description';
            }
            return null;
          },),
      ),
    ],
  );
}