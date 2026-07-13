
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/networking/api_constants.dart';
import 'package:taski/core/theming/styles.dart';
import 'package:taski/core/widgets/app_text_form_field.dart';
import 'package:taski/features/task_details/ui/widgets/select_from_cam_gallery_popup_menu.dart';
import '../../logic/task_details_cubit.dart';
import '../../models/one_task_model.dart';

Widget  taskDetailsAndImage(OneTaskModel model,TaskDetailsCubit cubit,BuildContext context){

  return  SizedBox(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      cubit.selectedImage==null?Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              height: 420.h,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(ApiConstants.imagesBaseUrl+model.image.toString(),))
              ),

            ),
            fromCamOrGalleryPopUpMenu(cubit,context)
          ],
        )
          :Stack(
        alignment: Alignment.topRight,
            children: [
      Image.file(cubit.selectedImage!,
             fit: BoxFit.fill,
             width: double.infinity,
             height: 420.h,
        ),
              IconButton(onPressed: (){
                cubit.clearSelectedImage();
              }, icon: Icon(Icons.close,color: Colors.red,size: 32.sp,))
            ],
          ),
        horizontalSpace(16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextFormField(
                  controller: cubit.titleController,
                  contentPadding: EdgeInsets.all(0),
                  hintText: "",
                  inputTextStyle: AppTextStyles.font24BlackBold,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  validator: (value){
                    if(value!.isEmpty){
                      return "please enter title";
                    }
                  }),
            //Text(model.data![0].title.toString(),style: AppTextStyles.font24BlackBold,maxLines: 1,overflow: TextOverflow.ellipsis,),
              verticalSpace(8),
              AppTextFormField(
                  controller: cubit.descriptionController,
                  contentPadding: EdgeInsets.all(0),
                  hintText: "",
                  inputTextStyle: AppTextStyles.font14DarkerGreyRegular,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  validator: (value){
                if(value!.isEmpty){
                  return "please enter description";
                }
                  }),

             // Text(model.data![0].desc.toString(),
            //    style: AppTextStyles.font14DarkerGreyRegular,),
            ],
          ),
        ),


      ],
    ),
  );

}