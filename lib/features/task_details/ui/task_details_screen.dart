import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/features/task_details/ui/widgets/task_desc_title_and_image.dart';
import 'package:taski/features/task_details/ui/widgets/task_details_app_par.dart';
import 'package:taski/features/task_details/ui/widgets/task_details_three_containers_builder.dart';

import '../../../core/theming/colors.dart';
import '../logic/task_details_cubit.dart';

class TaskDetailsScreen extends StatelessWidget {
 final String id;
 const TaskDetailsScreen({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskDetailsCubit()..getTask(context: context, id: id),
      child: BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          final String deepLinkData = "taskyapp://item?id=$id";
          var cubit = TaskDetailsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child:state is GetTaskLoading?Center(child: CupertinoActivityIndicator())
                  : Column(
                    children: [
                      taskDetailsAppPar(cubit,context,state),
                      Expanded(
                        child: SingleChildScrollView(
                                        physics: ClampingScrollPhysics(),
                                        child: Column(
                        children: [
                          taskDetailsAndImage(cubit.oneTaskModel,cubit,context),
                          verticalSpace(24),
                          taskDetailsThreeContainers(
                            cubit: cubit,
                            context: context
                          ),
                          verticalSpace(24),
                          QrImageView(
                            data: deepLinkData,
                            version: QrVersions.auto,
                            size: 200.0.sp,
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: AppColorsManager.black,
                            ),
                          ),


                        ],
                                        ),
                                      ),
                      ),
                    ],
                  ),
            ),
          );
        },
      ),
    );
  }
}
