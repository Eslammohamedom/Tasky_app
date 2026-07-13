import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/features/signup/logic/sighn_up_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import '../../logic/task_details_cubit.dart';

Widget taskDetailsAlertDialog(
    {required BuildContext context,required List<String> textList,required TaskDetailsCubit cubit,required bool isPriority}){
  return AlertDialog(
    content: SizedBox(
      height: 160.h,
      width: 30.w,
      // padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 16.h),
      child: ListView.separated(
          shrinkWrap: true,
          itemCount: textList.length,
          itemBuilder: (context,index){
            return dialogTextItem(textList: textList, index: index, context: context,cubit: cubit,isPriority: isPriority);
          },
          separatorBuilder: (context,index){return verticalSpace(16);}
      ),

    )
    ,
  );
}

Widget dialogTextItem({
 required bool isPriority ,
  required List<String> textList,required int index,required BuildContext context,required TaskDetailsCubit  cubit}){
  return GestureDetector(
    onTap: (){
     isPriority?cubit.selectPriority(index,context) :cubit.selectStatus(index,context);
    },
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