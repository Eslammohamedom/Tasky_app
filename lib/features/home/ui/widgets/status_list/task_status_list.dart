import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/home/logic/home_cubit.dart';
import 'package:taski/features/home/ui/widgets/status_list/task_status_item.dart';

Widget taskStatusList(HomeCubit cubit){
  return SizedBox(
    height: 40.h,
    child: ListView.builder(
      itemCount: cubit.tasksStatus.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return taskStatusItem(cubit, index);
      },
    ),
  );
}