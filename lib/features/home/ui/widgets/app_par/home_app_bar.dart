import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/theming/colors.dart';
import 'package:taski/core/theming/styles.dart';
import 'package:taski/features/home/logic/home_cubit.dart';
import 'package:taski/features/home/ui/widgets/app_par/sign_out_dialog.dart';

import '../../../../../core/routing/routs.dart';

Widget homeAppBar(BuildContext context,HomeState state,HomeCubit cubit)
{
  return SizedBox(
    height: 56.h,
    child: Row(
      children: [
        Text("Logo",style: AppTextStyles.font24BlackBold,),
        Spacer(),
        GestureDetector(
            onTap: (){
              context.pushNamed(Routes.profileScreen);
            },
            child: Icon(Icons.person_3_outlined,size: 24.sp,)),
        horizontalSpace(12),
    state is LogOutLoading
    ?  CupertinoActivityIndicator()
    : GestureDetector(
            onTap: (){
              showSignOutDialog(context,cubit);
            },
            child: Icon(Icons.logout_outlined,size: 24.sp,color: AppColorsManager.mainBlue,)),
      ],
    ),
  );
}