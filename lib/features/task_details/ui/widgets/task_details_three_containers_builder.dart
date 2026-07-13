import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/task_details/ui/widgets/task_details_three_containers_item.dart';

import '../../logic/task_details_cubit.dart';

Widget taskDetailsThreeContainers({

  required TaskDetailsCubit cubit,
  required BuildContext context,
}){
  return Padding(
    padding:  EdgeInsets.symmetric(horizontal: 24.0,),
    child: Column(
      children:[
        taskDetailsContainer(controller: cubit.dateController,isDate: true,isPriority: false,context: context,cubit: cubit),
        SizedBox(height: 16.h,),
        taskDetailsContainer(controller: cubit.statusController,isDate: false,isPriority: false,context: context,cubit: cubit),
        SizedBox(height: 16.h,),
        taskDetailsContainer(controller: cubit.priorityController,isDate: false,isPriority: true,context: context,cubit: cubit),


      ],

    ),
  );
}