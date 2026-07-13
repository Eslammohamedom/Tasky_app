import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/add_new_task/logic/add_task_cubit.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';
import 'add_task_dialog.dart';

Widget addImage(BuildContext context,AddTaskCubit cubit){
  return   cubit.selectedImage == null
      ? DottedBorder(
    options: RoundedRectDottedBorderOptions(
        color: AppColorsManager.mainBlue,
        radius: Radius.circular(12)),
    child: SizedBox(
      height: 50.h,
      width: double.infinity,
      child:     ElevatedButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context){
                return addTaskAlertDialog(context: context,height:100,textList: cubit.galleryOrCam,onTap:(index){
                  cubit.selectImageSource(index,context);
                });
              });
        },
        style: ButtonStyle(
            shape:   WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))  ,
          backgroundColor: WidgetStatePropertyAll(Colors.white)
        ),
        icon:  Icon(Icons.add_photo_alternate_outlined,size: 24.sp,color: AppColorsManager.mainBlue,),
        label: Text('Add Img',style:AppTextStyles.font19MainBlueMedium,),
      ),
    ),
  )
      :Stack(
    alignment: Alignment.topRight,
        children: [

          DottedBorder(
              options: RoundedRectDottedBorderOptions(
            color: AppColorsManager.mainBlue,
            radius: Radius.circular(12)),
              child: SizedBox(
          height: 200.h,
          width: double.infinity,
          child:ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
                cubit.selectedImage!, height: 482.h,
                width: double.infinity,
                fit: BoxFit.fill),
          ),
              ),
            ),
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.transparent,
            child: IconButton(
                onPressed: (){
                  cubit.deletePickedImage();
                }
                ,icon: Icon(Icons.close,size: 32.sp,color: Colors.red,)),
          ),
        ],
      );
}