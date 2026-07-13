import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

Widget addTaskAlertDialog({
  required BuildContext context,
  required List<String> textList,
  required void Function(int index) onTap,
  double height = 200,
}) {
  return AlertDialog(
    content: SizedBox(
      height: height.h,
      width: 30.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height.h,
            child: ListView.separated(
                shrinkWrap: true,
                itemCount: textList.length,
                itemBuilder: (context, index){
                  return dialogTextItem(
                    textList: textList,
                    index: index,
                    context: context,
                    onTap: () => onTap(index),
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(16);
                }),
          )
        ],
      ),
    ),
  );
}

Widget dialogTextItem({required List<String> textList,required int index,required BuildContext context,required GestureTapCallback onTap}){
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: 40.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
        decoration: BoxDecoration(
            color: AppColorsManager.grey,
            borderRadius: BorderRadius.circular(10.r)
        ),
        child: Text(textList[index],style: AppTextStyles.font18BlackMedium,)),
  );
}