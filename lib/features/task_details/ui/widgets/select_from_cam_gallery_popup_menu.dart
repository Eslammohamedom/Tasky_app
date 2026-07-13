import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../core/helpers/extentions.dart';
import '../../logic/task_details_cubit.dart';



Widget fromCamOrGalleryPopUpMenu(TaskDetailsCubit cubit,BuildContext context,){

  return PopupMenuButton<String>(
    menuPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
    icon: const Icon(Icons.camera_alt, color: AppColorsManager.black),
    elevation: 4,
    offset: const Offset(0, 45),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      // side: BorderSide(color: AppColorsManager.lighterGrey, width:0),
    ),
    color: Colors.white,
    onSelected: (String value) async{
      if (value == 'cam'){
        cubit.pickImage(ImageSource.camera);
      }else if (value == 'gallery'){
        cubit.pickImage(ImageSource.gallery);

      }
    },
    itemBuilder: (BuildContext context) => [
      PopupMenuItem<String>(
        value: 'gallery',
        height: 30.h, // Keeps the layout compact
        child: Center(
          child: Text(
              'Gallery',
              style: AppTextStyles.font16DarkMedium
          ),
        ),
      ),
      PopupMenuDivider(height: 1),
      PopupMenuItem<String>(
        value: 'cam',
        height: 30.h,
        child: Center(
          child: Text(
            'Camera',
            style: AppTextStyles.font16OrangeMedium,
          ),
        ),
      ),
    ],
  );
}