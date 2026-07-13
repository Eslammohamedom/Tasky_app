
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taski/core/networking/api_constants.dart';
import 'package:taski/core/theming/styles.dart';
import 'package:taski/features/home/ui/widgets/tasks_list/pop_up_menue.dart';
import '../../../../../core/helpers/extentions.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routing/routs.dart';
import '../../../logic/home_cubit.dart';
import '../../../models/all_tasks_model.dart';

Widget myTasksListItem(BuildContext context,List<Data> data,int index,HomeCubit cubit, HomeState state){
  DateTime parsedDate = DateTime.parse((data[index].createdAt).toString());
  return GestureDetector(
    onTap: ()async{
      await context.pushNamed(Routes.taskDetailsScreen,arguments: data[index].sId.toString());
      cubit.clearTasksListAndGetTasksData(context);
    },
    child: Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(image: NetworkImage(ApiConstants.imagesBaseUrl+data[index].image.toString()))
            ),
          ),
          horizontalSpace(8),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                   Expanded(child: Text(data[index].title.toString(),style: AppTextStyles.font16BlackBold,overflow: TextOverflow.ellipsis,)),
                    horizontalSpace(8),
                    Container(
                      height: 24.h,
                      padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 6.w),
                      decoration: BoxDecoration(
                        color: cubit.setStatusBackGroundColor(data[index].status.toString()),
                        borderRadius: BorderRadius.circular(5.r)
                      ),
                      child: Center(child: Text(data[index].status.toString(),style: AppTextStyles.font12BurbleMedium.copyWith(color:cubit.setStatusTextColor(data[index].status.toString()) ),)),
                    )
    
                  ],),
              ),
              Expanded(
                child: Text(data[index].desc.toString(),
                  style: AppTextStyles.font14GreyDarkRegular,
                  maxLines: 1,
                overflow: TextOverflow.ellipsis,),
              ),
              Expanded(
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.flag,size: 16,color: cubit.setPriorityTextColor(data[index].priority.toString(),)),
                        horizontalSpace(4),
                        Text(data[index].priority.toString(),style: AppTextStyles.font12OrangeMedium.copyWith(color: cubit.setPriorityTextColor(data[index].priority.toString())),)
                      ],
                    ),
                    Spacer(),
                    Expanded(child: Text(DateFormat('yyyy-MM-dd').format(parsedDate).toString(),maxLines:1,style: AppTextStyles.font12DarkerGreyRegular,))
                  ],
                )
              )
            ],
          )),

          iconMorePopUpMenu(cubit,context,data,index)
        ],
      ),
    
    ),
  );
}

