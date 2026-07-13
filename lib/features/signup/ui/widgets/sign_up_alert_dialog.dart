import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/features/signup/logic/sighn_up_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

Widget signUpAlertDialog(
    {required BuildContext context,required List<String> textList,required SignUpCubit cubit}){
  return AlertDialog(
    content: SizedBox(
      height: 200.h,
      width: 30.w,
      // padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 200.h,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: textList.length,
              itemBuilder: (context,index){
                return dialogTextItem(textList: textList, index: index, context: context,cubit: cubit);
              },
              separatorBuilder: (context,index){return verticalSpace(16);}
            ),
          )

        ],
      ),

    )
    ,
  );
}

Widget dialogTextItem({required List<String> textList,required int index,required BuildContext context,required SignUpCubit  cubit}){
  return GestureDetector(
    onTap: (){
    cubit.saveExperienceLevel(textList[index],context);
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